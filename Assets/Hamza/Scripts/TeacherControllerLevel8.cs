using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel8 : MonoBehaviour
{

    private Animation anim;

    public GameObject FaceFrontCam;
    public GameObject SideCam;

    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Walking");
       
        
    }

    public void OnTriggerEnter(Collider other)
    {

        if (other.tag == "facecamon")
        {
            FaceFrontCam.SetActive(true);
            SideCam.SetActive(false);
            anim.Play("Cry");
        }    
    }
}
