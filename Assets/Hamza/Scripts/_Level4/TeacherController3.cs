using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherController3 : MonoBehaviour
{


    private Animation anim;

   
    public GameObject FaceFrontCam;
   
    public GameObject SideCam;

    public GameObject Player;
    public GameObject PlayerControls;
    public GameObject LevelFailTeacher;
   
    


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
        
        if (other.tag == "facecamon")
        {
            FaceFrontCam.SetActive(true);
            SideCam.SetActive(false);
        }
        if(other.tag=="dooranim")
        {
            GameObject.FindGameObjectWithTag("door").GetComponent<Animator>().enabled = true;
        }
        if (other.tag == "sidecamon")
        {
            SideCam.SetActive(true);
            FaceFrontCam.SetActive(false);
            
        }
        if (other.tag == "Player")
        {
            LevelFailTeacher.SetActive(true);
            Invoke("Wait", 0.1f);
            Player.SetActive(false);
            PlayerControls.SetActive(false);
        }
    }



    public void Wait()
    {
        this.gameObject.SetActive(false);
    }

}
