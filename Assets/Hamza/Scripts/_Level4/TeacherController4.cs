using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherController4 : MonoBehaviour
{

    public GameObject FaceFrontCam;
    public GameObject SideCam;
    private Animation anim;

    public GameObject Scene4;
    public GameObject Scene5;


    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Walking");
        
    }

    public void OnTriggerEnter(Collider other)
    {
      
        if (other.tag == "sit")
        {
            anim.Play("Sit");
            FaceFrontCam.SetActive(false);
            SideCam.SetActive(true);
            Invoke("SceneActive", 1.5f);

        }
    }


    public void SceneActive()
    {
        Scene4.SetActive(false);
        Scene5.SetActive(true);
    }
}
