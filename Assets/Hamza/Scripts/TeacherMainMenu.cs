using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherMainMenu : MonoBehaviour
{


    private Animation anim;



    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animation>();

        anim.Play("Walking");
    }

    public void OnTriggerEnter(Collider other)
    {

        if (other.tag == "salsa")
        {
            anim.Play("Salsa");
        }

    }

}
