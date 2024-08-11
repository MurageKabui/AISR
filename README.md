# AISR



<p align="center">
  <img width="100" height="100" src="https://github.com/MurageKabui/AISR/blob/main/AISR.png?raw=true"><br>
</p>

<p align="center">
	AISR is an attempt to employ AI to autonomously generate intelligent and contextually accurate replies to incoming SMS messages on Android.
</p>

---

## How It Works

```mermaid
sequenceDiagram
    participant Device as Device
    participant CordovaApp as AISR
    participant SMSReceive as cordova-plugin-sms-receive
    participant AI as GroqCloud AI API
    participant User as End User

    Device->>CordovaApp: device ready event triggered
    CordovaApp->>User: Prompt to allow Watching SMS messages
    CordovaApp->>SMSReceive: onSMSArrive event registered in DOM
    SMSReceive-->>CordovaApp: Incoming SMS detected
    CordovaApp->>CordovaApp: Extract body, address and date from message
    CordovaApp->>AI: Send SMS body to AI for reply generation
    AI-->>CordovaApp: Contextually accurate reply generated
    CordovaApp->>CordovaApp: Reply is rendered into chatbox
    CordovaApp->>User: Prompt user to send reply (adjustable timer)
    User-->>CordovaApp: User allows reply (before timer ends)?
    alt User approves reply
        CordovaApp->>SMSReceive: Send reply to address using plugin
    else User disapproves or timer ends
        CordovaApp->>SMSReceive: Don't send or cancel reply
    end
```

<details>

   <summary>step-by-step breakdown</summary>
  
  
   1. **Device Initialization**: 
       - The app is launched, `deviceready` event is fired, it signifies the app is ready to interact with native plugins and features via cordova.
    
   2. **Registering the SMS Listener**:
       - After firing the `deviceready` event, if SMS watching is allowed, an event listener ``onSMSArrive`` from ``cordova-plugin-sms-receive`` is registered. This listener is responsible for detecting incoming SMS messages on the host device.
       
       > This is assuming that the Phone and SMS permission is allowed.
    
   3. **Capturing Incoming SMS**:
       - When a new SMS message is detected, `onSMSArrive` event is triggered.  We proceed to extract the SMS data, specifically the message body, sender's address and the current date.
    
   4. **AI-Powered Response Generation**:
       - The extracted SMS body along with the last nth messages are sent to Groqcloud AI API for analysis in order to generate a contextually accurate reply.
       
       > A system prompt can be set-up to allow a personalized processing for the message.
    
   5. **User Interaction**:
       - After the AI generates a reply, the app prompts the user to review and approve the response. An adjustable timer is initiated, giving the user a specified amount of time to approve or modify the reply.
    
   6. **Automated Reply**:
       - If the user approves the AI-generated reply within the given time, the reply is sent back to the original sender.
       
       If the timer expires without user intervention, the app can either send the reply automatically or cancel the operation based on predefined settings.
  
</details>
