using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel5 : MonoBehaviour
{


    private Animation anim;

   
  

   
    
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Walking");
        Invoke("CryAnim", 2.5f);
        
    }


    public void CryAnim()
    {
        anim.Play("Cry");
    }
   

}
