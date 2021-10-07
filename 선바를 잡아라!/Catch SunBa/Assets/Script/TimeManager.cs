using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TimeManager : MonoBehaviour
{
    public Image timeFG;

    float startTime, remainingTime, stopTime = 0;
    public bool checkStop=false,checkMinus=false;

    SunbaManager sunbaM;

    private void Awake()
    {
        sunbaM = GameObject.Find("SunbaManager").GetComponent<SunbaManager>();
    }
    // Start is called before the first frame update
    void Start()
    {
        //게임 시작시간
        startTime = Time.time + 60;
    }

    // Update is called once per frame
    void Update()
    {
        set_RemainingTime();
        set_TimeBar();

        //시간 멈춤
        if(checkStop==true)
        {
            set_StopTime();
        }
        //시간 감소
        if(checkMinus==true)
        {
            set_MinusTime();
        }
    }

    //타이머 세팅
    void set_RemainingTime()
    {
        remainingTime = startTime - Time.time + stopTime;

        //남은시간 0이면 게임오버
        if(remainingTime<=0)
        {
            sunbaM.GameOver = true;
        }
    }

    //타이머바 세팅
    void set_TimeBar()
    {
        if (checkStop == false)
        {
            timeFG.GetComponent<Image>().color = new Color(1, 1, 1);
            //남은시간 만큼 타이머바 길이 조절
            timeFG.GetComponent<RectTransform>().sizeDelta = new Vector2(1282 * (remainingTime / 60), 30);
        }
        else if (checkStop == true)
        {
            timeFG.GetComponent<Image>().color = new Color(0, 1, 1);
        }
    }
    //시간 멈추기
    void set_StopTime()
    {
        stopTime += Time.deltaTime;

        if(stopTime>4)
        {
            checkStop = false;
            startTime += stopTime;
            stopTime = 0;
        }
    }
    //시간 감소
    void set_MinusTime()
    {
        startTime -= 3f;
        checkMinus = false;
    }
}
