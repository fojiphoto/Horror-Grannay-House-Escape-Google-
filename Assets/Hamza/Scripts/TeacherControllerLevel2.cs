using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel2 : MonoBehaviour
{


    private Animation anim;

   
   
   
    
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Laying");
        
        
    } 

}
