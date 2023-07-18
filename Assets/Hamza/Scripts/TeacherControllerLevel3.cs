using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel3 : MonoBehaviour
{


    private Animation anim;

    public GameObject Fire;
    public GameObject TeacherInTab;
   
   
   
    
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Cry");

        Fire.SetActive(true);
        TeacherInTab.SetActive(false);
    } 

}
