using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class Person
{
    public int id = 1;
    public float height = 1.7f;
    public bool sex = true;
    public string name = "aaa";
}

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        // InputManger.Instance.Start();
        // EventCenter.Instance.AddEventListener(KeyCode.A + "按下", () =>
        // {
        //     print("A按下");
        // });
        // EventCenter.Instance.AddEventListener(KeyCode.A + "抬起", () =>
        // {
        //     print("A抬起");
        // });
        //
        // MapInfoContainer mapInfoContainer = BinaryManager.Instance.LoadExcelBinary<MapInfo, MapInfoContainer>();

        // Person p1 = new Person();
        // BinaryManager.Instance.Save("Person", p1);

        // Person p2 = BinaryManager.Instance.Load<Person>("Person");

        ABManager.Instance.LoadAsync<GameObject>("test", "Cube", (gameObject) =>
        {
            
        });
    }

}
