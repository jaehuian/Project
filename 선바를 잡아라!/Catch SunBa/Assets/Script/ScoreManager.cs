using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreManager : MonoBehaviour
{
    public int score = 0;
    public bool checkFever=false,checkFeverAni=true,checkFeverAni2=false;
    float feverTime = 0;

    public Text scoreText;
    RectTransform feverRect;
    Animation feverAni,feverAni2;
    private void Awake()
    {
        scoreText.text = "Score : 000";

        feverRect = GameObject.Find("Fever").GetComponent<RectTransform>();
        feverAni = GameObject.Find("Fever").GetComponent<Animation>();
        feverAni2 = GameObject.Find("FeverBG").GetComponent<Animation>();
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        set_ScoreText();

        if(checkFever==true)
        {
            start_Fever();
        }
    }
    //스코어 출력
    void set_ScoreText()
    {
        if(score>99)
            scoreText.text = "Score : " + score.ToString();
        else if(score>9)
            scoreText.text = "Score : " + "0" + score.ToString();
        else if (score > 0)
            scoreText.text = "Score : " + "0" + "0" + score.ToString();
    }
    //스코어 갱신
    public void add_Score(int grade)
    {
        if (checkFever == false)
            score += grade;
        else if (checkFever == true)
        {
            score += grade * 2;
        }
    }
    //피버 시간(5초)
    void start_Fever()
    {
        Debug.Log("start Fever");

        //피버 애니메이션 실행
        if(checkFeverAni==true)
        {
            feverAni.Play();
            checkFeverAni = false;
        }
        feverAni2.Play();

        feverTime += Time.deltaTime;

        if(feverTime>=5)
        {
            checkFever = false;
            checkFeverAni = true;

            feverRect.anchoredPosition = new Vector2(1290f, 0);
            feverTime = 0;
        }
    }
}
