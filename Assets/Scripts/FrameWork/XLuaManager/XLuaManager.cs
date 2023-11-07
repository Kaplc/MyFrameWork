using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class XLuaManager : BaseSingleton<XLuaManager>
{
    public LuaEnv luaEnv;

    public XLuaManager(){
        luaEnv = new LuaEnv();
    }

    public void RunLua(string fillName){
        luaEnv.DoString(fillName);
    }
}
