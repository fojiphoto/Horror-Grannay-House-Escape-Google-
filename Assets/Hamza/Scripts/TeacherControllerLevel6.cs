using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel6 : MonoBehaviour
{


    private Animation anim;

   

    


    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Walking");
        
        
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }

    public void OnTriggerEnter(Collider other)
    {
        
        if (other.tag == "Disappointed")
        {
             anim.Play("Disappointed");
        }
        
    }


   
   

}
