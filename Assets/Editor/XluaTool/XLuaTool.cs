using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;


public static class XLuaTool
{
    [MenuItem("Editor/XLuaTool/GenerateTxt")]
    public static void GenerateTxt()
    {
        string luaFilePath = Application.dataPath + "/Lua/";

        if (!Directory.Exists(luaFilePath))
        {
            Debug.Log("无Lua文件夹");
            return;
        }

        // 每次清空旧文件
        if (Directory.Exists(luaFilePath + "LuaText/"))
        {
            string[] oldFilesPath = Directory.GetFiles(luaFilePath + "LuaText/", "*.txt");
            for (int i = 0; i < oldFilesPath.Length; i++)
            {
                File.Delete(oldFilesPath[i]);
            }
        }
        
        string[] filesPath = Directory.GetFiles(luaFilePath, "*.lua");

        for (int i = 0; i < filesPath.Length; i++)
        {
            if (!Directory.Exists(luaFilePath + "LuaText/"))
                Directory.CreateDirectory(luaFilePath + "LuaText/");

            string[] res = filesPath[i].Split('/');

            File.Copy(filesPath[i], luaFilePath + "LuaText/" + res[res.Length - 1] + ".txt");
        }

        AssetDatabase.Refresh();
    }
}
