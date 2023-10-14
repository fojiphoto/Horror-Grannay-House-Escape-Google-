using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TextTypingAnimationTMP : MonoBehaviour
{
    public TMP_Text textMeshPro; 
    public string fullText= "Tim: Hello, Hello, 911 Emergency!! I'm stuck in this house, please help me. \b 911: (Signal issue, unclear sounds, a girl asks from 911) PLEASE speak clearly, we can't hear you.\b Tim: Please, save me from this Grimsy Monster. I'm very scared.\b 911: Can you please tell us your location?\b Tim: I'm in the basement of a house, but I don't know exactly where. I'm really scared; please help me.\b 911: It's difficult for us to help in such a situation, but until help arrives, keep yourself hidden and save yourself from the Grimsy monster.";
    public float typingSpeed = 0.001f;

    private int characterIndex = 0;

    private void Start()
    {
        if (textMeshPro == null)
        {
            Debug.LogError("TextMeshPro component is not assigned!");
            enabled = false;
            return;
        }

        if (fullText == null)
        {
            Debug.LogError("Full text is not set!");
            enabled = false;
            return;
        }

        textMeshPro.text = "";
        //StartCoroutine(TypeText());
        Invoke(nameof(StartCoroutine),2f);
    }
    void StartCoroutine() 
    {
        StartCoroutine(TypeText());
    }

    private IEnumerator TypeText()
    {
        while (characterIndex < fullText.Length)
        {
            textMeshPro.text += fullText[characterIndex];
            characterIndex++;
            yield return new WaitForSeconds(typingSpeed);
        }
    }
}
