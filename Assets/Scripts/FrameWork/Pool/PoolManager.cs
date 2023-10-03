using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PoolData
{
    // 该容器的父对象
    public GameObject father;

    // 储存的所有游戏对象list
    public List<GameObject> objectList;

    public PoolData(string objectName, GameObject poolObject)
    {
        objectList = new List<GameObject>();
        // 用对象名字创建父对象储存list
        father = new GameObject(objectName);
        // 设为pool对象的子物体
        father.transform.parent = poolObject.transform;
    }

    public GameObject Get()
    {
        GameObject targetObject;
        if (objectList.Count > 0)
        {
            // 获取末尾的对象
            targetObject = objectList[objectList.Count - 1];
            // 断开父子关系
            targetObject.transform.parent = null;
            // 激活
            targetObject.SetActive(true);
            // 从list移除
            objectList.Remove(targetObject);
        }
        else
        {
            // 异步加载资源
            targetObject = GameObject.Instantiate(Resources.Load<GameObject>(father.name));
            targetObject.name = father.name;
        }

        return targetObject;
    }

    public void Push(GameObject gameObject)
    {
        objectList.Add(gameObject);
        // 设置为list的子对象
        gameObject.transform.SetParent(father.transform);
        // 失活
        gameObject.SetActive(false);
    }
}

public class PoolManager : BaseSingleton<PoolManager>
{
    // 容器
    private Dictionary<string, PoolData> poolDic;

    // 缓存池对象
    private GameObject poolObject;

    // 初始化缓存池
    private void Init()
    {
        poolDic = new Dictionary<string, PoolData>();
        // 在场景上创建物体统一管理内容
        poolObject = new GameObject("Pool");
    }

    // 获得对象
    public GameObject GetObject(string fullName)
    {
        // 初始化缓存池
        if (!poolObject) Init();

        // 字典获取
        if (poolDic.TryGetValue(fullName, out PoolData poolData))
        {
            return poolData.Get();
        }

        // 无对象则创建新list
        poolDic.Add(fullName, new PoolData(fullName, poolObject));
        return poolDic[fullName].Get();
    }

    // 储存对象
    public void PushObject(GameObject gameObject)
    {
        if (!poolObject) Init();

        // 有list
        if (poolDic.TryGetValue(gameObject.name, out PoolData poolData))
        {
            poolData.Push(gameObject);
        }
        else // 无list
        {
            // 创建新list
            poolDic.Add(gameObject.name, new PoolData(gameObject.name, poolObject));
            // 再储存
            poolDic[gameObject.name].Push(gameObject);
        }
    }
}