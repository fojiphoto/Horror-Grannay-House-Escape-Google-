using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class dooropener : MonoBehaviour
{
    //public Animator[] doors;
    //public GameObject[] Entrys;
    // Start is called before the first frame update
    //public GameObject Door;
    public float startangle,  endangle, speed;
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
            openercloser();
            testing = false;
        }
    }


    private void OnTriggerEnter(Collider col)
    {

        if (col.gameObject.tag == "Emerald AI")
        {

            //  GetComponent<Animator>().Play("door");
            openercloser();
            Debug.Log("detextecd!!!!!!!");
        
        }
    }

    private void OnTriggerExit(Collider col)
    {

        if (col.gameObject.tag == "Emerald AI")
        {
           // GetComponent<Animator>().Play("door1");
                 openercloser();
            Invoke("closedoor", 3f);
        }

    }


    void closedoor() {


    GetComponent<Animator>().Play("door1");
   
    }

    public void openercloser() {

       
        if (opened)
        {
            iTween_new.RotateTo(this.gameObject, iTween_new.Hash(a, endangle, "time", speed, "islocal", true, "easetype", iTween_new.EaseType.linear));
            opened = false;
        }
        else
        {
            iTween_new.RotateTo(this.gameObject, iTween_new.Hash(a, startangle, "time", speed, "islocal", true, "easetype", iTween_new.EaseType.linear));
            opened = true;
        }
    }
    
}
