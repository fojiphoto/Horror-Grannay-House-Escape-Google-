using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherControllerLevel1 : MonoBehaviour
{


    private Animation anim;


  

    public GameObject LevelFailTeacher;
    public GameObject Player;
    public GameObject PlayerControls;
   
    
    void Start()
    {
        anim = GetComponent<Animation>();
        
        anim.Play("Walking");
        
        
    }


    public void OnTriggerEnter(Collider other)
    {
        
        
        if(other.tag == "Player")
        {
            LevelFailTeacher.SetActive(true);
            Invoke("Wait",0.1f);
            Player.SetActive(false);
            PlayerControls.SetActive(false);
        }
    }

    public void Wait()
    {
        this.gameObject.SetActive(false);
    }

}
