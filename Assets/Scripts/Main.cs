using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        InputManger.Instance.Start();
        EventCenter.Instance.AddEventListener(KeyCode.A + "按下", () =>
        {
            print("A按下");
        });
        // EventCenter.Instance.AddEventListener(KeyCode.A + "长按", () =>
        // {
        //     print("A长按");
        // });
        EventCenter.Instance.AddEventListener(KeyCode.A + "抬起", () =>
        {
            print("A抬起");
        });
    }
}
