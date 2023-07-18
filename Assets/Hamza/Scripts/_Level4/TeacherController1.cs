using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherController1 : MonoBehaviour
{


    private Animation anim;

    //public GameObject Fading;
    public GameObject Scene1;
    public GameObject Scene2;
    public GameObject NewsPaperGround;
    public GameObject NewsPaperHand;


    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animation>();
     
        anim.Play("Walking");
        //Invoke("walkAnim", 5.0f);
        
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }

    public void OnTriggerEnter(Collider other)
    {
        if(other.tag == "newspaper")
        {
            anim.Play("Picking Up");
            StartCoroutine(fadewait());
            Invoke("Newspaper", 2.5f);
           
        }
        
        if(other.tag=="dooranim")
        {
            GameObject.FindGameObjectWithTag("door").GetComponent<Animator>().enabled = true;
        }
    }

    //public void walkAnim()
    //{
        
     //   anim.Play("Walking");

    //}
    public void Newspaper()
    {
        NewsPaperGround.SetActive(false);
        NewsPaperHand.SetActive(true);
    }
    IEnumerator fadewait()
    {
        //yield return new WaitForSeconds(3.0f);
        //Fading.SetActive(true);
        yield return new WaitForSeconds(5.0f);
        Scene1.SetActive(false);
        Scene2.SetActive(true);
        
    
    }

}
