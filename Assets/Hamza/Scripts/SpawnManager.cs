using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;

public class SpawnManager : MonoBehaviour
{
    public Transform[] positions;
    public GameObject pos;
    public GameObject player;
    public int level;
    // Start is called before the first frame update
    public static SpawnManager Instance;

    private void Awake()
    {
        if (Instance==null)
        {
            Instance = this;
        }
       // player.transform.position = pos.transform.position;
        //transform.position = pos.transform.position;
    }
    void Start()
    {
        level = PlayerPrefs.GetInt("Level");
        Debug.Log("Level " + level);
        //  Instantiate(player, pos.transform.position, Quaternion.identity);
        //Invoke(nameof(LoadPlayerPos), 2f);
        if (PlayerPrefs.GetInt("Revived")>0)
        {
            Invoke(nameof(StartFPS), 2f);
            LoadPos();
        }
        else
        {
            Invoke(nameof(StartFPS), 2f);
        }
        
        //LoadPlayerPos();
        // Debug.Log("Player pos "+ transform.position);
        //if (level == 1)
        //{
        //    player.transform.position = positions[1].position;
        //}

    }
    public void SavedPostion()
    {
        PlayerPrefs.SetFloat("XPos", transform.position.x);
        PlayerPrefs.SetFloat("YPos", transform.position.y);
        PlayerPrefs.SetFloat("ZPos", transform.position.z);
    }
    // Update is called once per frame
    void Update()
    {

        SavedPostion();
    }

    public void LoadPos()
    {
       float x= PlayerPrefs.GetFloat("XPos");
       float y= PlayerPrefs.GetFloat("YPos");
       float z= PlayerPrefs.GetFloat("ZPos");
        transform.position = new Vector3(x, y, z);
    }

    public void LoadPlayerPos()
    {
        
        transform.position = positions[PlayerPrefs.GetInt("Level",0)].transform.position;
    }

    public void StartFPS()
    {
        transform.GetComponent<FirstPersonController>().enabled = true;
    }
    public void CloseFPS()
    {
        transform.GetComponent<FirstPersonController>().enabled = false;
       
       
    }
}
