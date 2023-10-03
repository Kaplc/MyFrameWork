using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Miss : MonoBehaviour
{
    // Start is called before the first frame update
    void OnEnable()
    {
        Invoke("MissMe", 3f);
    }
    
    void MissMe()
    {
        PoolManager.Instance.PushObject(gameObject);
    }
}
