using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class Dialough : MonoBehaviour {

	public float TimePause = 0.0001f;
	string Complete_Text=null;
	char[] CharText=null;
	//public AudioClip _AudioClip;
	//AudioSource _AudioSource;
//	public GameObject DlgBar;
	public Text DlgBar_Text;

	//public GameObject Joystick;

	void Start () {
	}
	public void ShowDlgBar(string messege)
	{
		//	DlgBar.SetActive (true);
		//Joystick.GetComponent<Image> ().enabled = false;
		//Debug.Log ("Type TExt\t"+messege);
		CharText = messege.ToCharArray();
		Complete_Text = null;
		DlgBar_Text.text=null;
		DlgBar_Text.enabled = true;
		StartCoroutine (typeText());

	}

	IEnumerator typeText()
	{
		for (int i = 0; i <=CharText.Length; i++) {
			if (i!=CharText.Length) {
				Complete_Text += CharText [i].ToString();
				DlgBar_Text.text = Complete_Text;
			} 
			yield return new WaitForSeconds (TimePause);
			//Time.timeScale = 0;
		}
		}
}
