using System.IO;
using UnityEngine;
using XLua;

namespace ZFrameWork
{
    public class XLuaManager : BaseSingleton<XLuaManager>
    {
        public LuaEnv luaEnv;

        // 属性提供访问_G表
        public LuaTable _G
        {
            get => luaEnv.Global;
        }

        public XLuaManager()
        {
            luaEnv = new LuaEnv();
            // 重定向执行路径，执行脚本时先去寻找该路径
            luaEnv.AddLoader(AddLuaFilePath); 
            luaEnv.AddLoader(AddABLuaFilePath); 
        }

        public void RunLua(string fillName)
        {
            luaEnv.DoString($"require(\"{ fillName}\")");
        }

        public void DoString(string str)
        {
            luaEnv.DoString(str);
        }

        #region 重定向执行Lua脚本执行路径

        // 普通路径
        public byte[] AddLuaFilePath(ref string fileName)
        {
            string path = Application.dataPath + "/Lua/" + fileName + ".lua";

            if (File.Exists(path))
            {
                // 返回读取到的Lua脚本字节数据
                return File.ReadAllBytes(path);
            }

            return null;
        }

        // AB包中获取文件
        public byte[] AddABLuaFilePath(ref string fileName)
        {
            TextAsset lua = ABManager.Instance.Load<TextAsset>("Lua", fileName);

            if (lua != null)
            {
                return lua.bytes;
            }

            return null;
        }

        #endregion

        /// <summary>
        /// lua的GC
        /// </summary>
        public void Tick()
        {
            luaEnv.Tick();
        }

        /// <summary>
        /// 销毁lua解析器
        /// </summary>
        public void Dispose(){
            luaEnv.Dispose();
            luaEnv = null;
        }
    }
}
