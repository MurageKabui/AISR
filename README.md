# AISR

<p align="center">
  <img width="100" height="100" src="https://github.com/MurageKabui/AISR/blob/main/Logo.png?raw=true"><br>
</p>

<p align="center">
	AISR is an attempt to employ AI to generate intelligent and contextually accurate replies to incoming SMS messages on Android.
</p>

---

 *Preview Images Here*

<br>

|  Source | Download ``.apk`` |
|---------|----------|
| *Github* | [link](www.githhub.com) |
| *F-Droid* | N/A |
| *Playstore* | N/A |

## 🤔 How It Works

```mermaid
sequenceDiagram
    participant Device as Android Device
    participant CordovaApp as AISR App
    participant SMSReceive as cordova-plugin-sms-receive
    participant Storage as Local Storage
    participant AI as GroqCloud AI API
    participant User as End User

    Device->>CordovaApp: device ready event triggered
    CordovaApp->>Storage: Load user preferences
    CordovaApp->>User: Prompt for SMS permissions (if not granted)
    User-->>CordovaApp: Grant SMS permissions
    CordovaApp->>SMSReceive: Initialize and register onSMSArrive event
    CordovaApp->>CordovaApp: Start background service

    loop Background Service Running
        SMSReceive-->>CordovaApp: Incoming SMS detected
        CordovaApp->>CordovaApp: Extract body, address, date from message
        CordovaApp->>Storage: Store incoming SMS details
        CordovaApp->>CordovaApp: Apply user-defined filters (if any)
        alt SMS passes filters
            CordovaApp->>AI: Send SMS body and context to AI
            AI->>AI: Process request (tokenize, analyze, generate)
            AI-->>CordovaApp: Return contextually accurate reply
            CordovaApp->>CordovaApp: Apply post-processing rules
            CordovaApp->>Storage: Store AI-generated reply
            CordovaApp->>CordovaApp: Render reply in chatbox
            CordovaApp->>User: Notify user of new message (based on settings)
            CordovaApp->>CordovaApp: Start adjustable reply timer
            
            alt User interaction before timer ends
                User->>CordovaApp: Open app and review reply
                User-->>CordovaApp: Edit reply (optional)
                User-->>CordovaApp: Approve or reject reply
            else Timer ends without user interaction
                CordovaApp->>CordovaApp: Handle based on user preferences
            end

            alt Reply approved (by user or auto)
                CordovaApp->>Device: Send reply via SMS
                Device-->>CordovaApp: SMS sent confirmation
                CordovaApp->>Storage: Update conversation history
            else Reply rejected or cancelled
                CordovaApp->>Storage: Mark reply as rejected
            end
        else SMS filtered out
            CordovaApp->>Storage: Log filtered SMS
        end
    end

    par Error Handling
        CordovaApp->>CordovaApp: Monitor for errors (API, SMS, etc.)
        CordovaApp->>User: Notify of critical errors
        CordovaApp->>Storage: Log errors for troubleshooting
    and Battery Optimization
        CordovaApp->>Device: Request battery optimization exemption
        Device-->>CordovaApp: Grant/Deny optimization exemption
        CordovaApp->>CordovaApp: Adjust background service based on battery status
    and Periodic Tasks
        CordovaApp->>Storage: Perform periodic cleanup of old data
        CordovaApp->>AI: Periodic model updates or fine-tuning
    end
```

<details>

   <summary>A step-by-step breakdown</summary>
  
  
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

## ✨Features

Here are some of the key features included in the app, aimed at making things more convenient and customizable ..

* [x] Customizable System Prompt
    > This will allow the user to tweak the system prompt so the generated replies suit their preferences and personalities.

* [x] Voice enabled interactions
    > Automatically reads incoming messages aloud and voices the AI-generated reply. Users can choose from various voices and respond with "yes" to send the reply or "no" to cancel it..

* [ ] Suggested Replies
    > Provides context-aware replies by analyzing the chat history and presents relevant, pre-formulated replies that users can select and send back. Suggested Replies adapt to the user's communication style over time, providing increasingly personalized and relevant options.
