using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelFailTeacher : MonoBehaviour
{




    // Start is called before the first frame update
    void Start()
    {
       
        transform.position = GameObject.FindGameObjectWithTag("caught").transform.position;
        transform.rotation = GameObject.FindGameObjectWithTag("caught").transform.rotation;

        Invoke("OnFail", 3.0f);
    }

    public void OnFail()
    {
        GamePlayUI.Instance.OnFail();
    }
}
