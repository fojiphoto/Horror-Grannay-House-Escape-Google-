using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class draweropener : MonoBehaviour
{
  
    public float startlength,  endlength, speed;
    public bool opened, testing;
    public char a;
       

    void Start()
    {
        testing = true;
        //iTween_new.RotateTo(Door, iTween_new.Hash("x", end.eulerAngles.x, "y", end.eulerAngles.y, "z", end.eulerAngles.z, "time", 0.5f, "islocal", true, "easetype", iTween_new.EaseType.linear));
        // iTween_new.RotateTo(this.gameObject, iTween_new.Hash("y", angle, "time", speed, "islocal", true, "easetype", iTween_new.EaseType.linear));

    }

    private void Update()
    {
        if (testing)
        {
            drawer();
            testing = false;
        }
    
    }



    
    public void drawer() {


        if (opened)
        {
            iTween_new.MoveTo(this.gameObject, iTween_new.Hash( a, endlength, "time", 0.5f, "islocal", true, "easetype", iTween_new.EaseType.linear));
            opened = false;
        }
        else
        {
            iTween_new.MoveTo(this.gameObject, iTween_new.Hash( a, startlength, "time", speed, "islocal", true, "easetype", iTween_new.EaseType.linear));
            opened = true;
        }
    }
    
}
