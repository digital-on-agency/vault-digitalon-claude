<!-- ultimo aggiornamento: 2026-03-21 -->

# Google Analytics

## Overview

**Google Analytics** is a web analytics service by Google that tracks and reports website or app traffic, user behavior, and conversion data.
It provides actionable insights into how visitors interact with your content, which marketing channels drive the most engagement, and where improvements can be made to increase performance.
Google Analytics works by embedding a tracking code into your site that collects data on page views, events, user demographics, device types, and more.
This data is then processed and presented in an interactive dashboard, enabling both marketers and developers to make informed, data-driven decisions to optimize user experience, content strategy, and ROI.

**Prerequisite:** Ensure that Google Tag Manager (or another tracking implementation method) is already installed on your site so the Google Analytics tag can be deployed and start collecting data.

You can try the features on the [GA4 Demo Account](https://support.google.com/analytics/answer/6367342#access&zippy=%2Cin-this-article).

## Setup

### How GA4 Works

#### How the measurement is done

GA4 is based on cookies, it process any browser as a different user with a random number and the first timestamp in which the user visits our site, these two values joined together make the **Client ID**.
We have to put the GA4 measurement code in every page of our site. That code check if there are the GA4 cookie in the browser and, if there isn't, it create one.

[Introduction to server-side tagging](https://developers.google.com/tag-platform/tag-manager/server-side/intro?utm_source=advocacy&utm_medium=social&utm_campaign=gtm)
[Enhanced measurement events](https://support.google.com/analytics/answer/9216061?hl=en)

#### Basic Metrics

[What is a user in GA4](https://www.measurelab.co.uk/blog/users-ga4/)

##### User Identification

*Users (GA4 world)* is the highest entity we are measuring and operating with, something closest to **devices**.
One *user* can have multiple *Sessions* during their interaction with the website and during a *session* there are multiple *Views* or *Events* occurring.

We aren't measuring **users** as **humans** but something more closer to **devices**.

There are 4 methods of identification in GA4:
1. **User ID:** we need to implement a way to send this ID to GA4 with every hit and we need to let GA4 know that
2. **Google Signals:** If someone with a Google account gives permission, GA4 can create its own User ID
3. **Device ID:** this is the most used, the identifier is stored in the cookies
4. **Modelling:** this is the most advanced, works for users who are non-consenting to be measured but Google still can anonymously track them.

We can choose which method to use by going to `Admin > Data Display > Reporting Identity` from our [Google Analytics Workspace](https://analytics.google.com/analytics/).

##### Session & Engagement

**Session:** a group of user's interactions with the website. By interaction we mean *page view* and events like *adding product to cart* or *purchasing*. If not adjusted, the time window between interactions cannot be longer than 30 minutes.

**Engaged Session:** The way Google defines it is based on 3 conditions:
1. Lasted more than 10 seconds
2. Included conversion
3. 2 or more page views

If one or more of these conditions are satisfied, the session is marked as **engaged**.

**Engagement Rate:** the percentage of engaged sessions out of the total number of sessions.

**Bounce Rate:** The volume (percentage) of the sessions which bounced without performing any other interactions.
$$\text{Bounce Rate}=1 - \text{Engagement Rate}$$

By going to `Admin > Property Settings > Data Streams > choose a datastream > Configure Tag Settings > Show More > Adjust session timeout` we can change the amount of seconds to consider a session engaged (condition 1).
In the same section, we can choose the amount of inactivity time to **consider a session expired**.

##### Users

**Active Users:** are the users who had at least one **engaged session**. There are always more **Total Users** than **Active Users**.

##### Time measurement

The time is measured by the events timestamp (pageview or others), then GA4 calculates how much time passes between one event and another. GA4 gets 0 minutes of the last page viewing because the exit isn't an event and doesn't send a timestamp.

The problem is that this system does not consider the option where a user visits other sites between one event and another on our site, which is why engagement is a much more used and reliable metric.

The problem was solved by adding the **Unload Event**, that could be the unfocus or the closure of our website. With this event we can get a report closer to reality and also know how much time the user spent on the last page.

### Create and Configure the Account

**TODO**

### Basic setup - Data stream

The first thing to do is to **create the account**. Login into Google with any GA4 account and click on `Admin > Create Property`, insert required information. Then select the platform type (`Web`, `Android App` or `iOS App`), setup the relative **data stream** with the required information, for web: `stream name` and `site URL`, and the **enhanced measurement**, the possibility to measure some interactions and content in addition to standard `pageview`.

### Hardcoded measurement - Tag instructions

In `Web Stream Details` (if you chose `web` as platform), you can find `Tag Instructions`. By selecting it you can connect your website to GA4:
* **Install with a website builder:** if your builder is in the list, you can automatically connect the system by selecting the correct builder
* **Install manually:** you will see the **HTML Google Tag** and you have to copy and paste it in your website on each page, ideally as high as possible in the HTML code. This is the moment from which you start collecting data.

## Configurazioni standard

### Data Retention

By going to `Admin > Data Settings > Data Retention` you can increase the retention of the data from 2 to 14 months. In this way you will have a lot more data you can then aggregate.

### Data Stream Tag Setting

By going to `Admin > Data Stream > [your data stream] > Configure tag settings` you can access 2 useful features:
* **List of unwanted referral:** you can define the list of unwanted referrals that should be excluded from referral traffic in GA4, preventing sessions from being attributed to those sources (e.g. payment gateways) instead of the original traffic source.
* **Adjust session timeout:** you can edit the timing values for session timeout and engaged session. Adjusting the timer for engaged sessions lets you define how long a user must stay active (e.g. 10s vs 30s) before GA4 counts it as engagement, which affects metrics like bounce rate and engagement rate.

### Modify events

By going to `Admin > Data Stream > Modify Events` you can adjust event parameters or rename events directly in GA4, so data is cleaned or standardized before being processed in reports. Here you can create rules that rename events or change their parameters by setting conditions (e.g. when event name = X, change it to Y).

## Workflow

### Generic Workflow to implement Analytics on a website

1. Write the Analytics Documentation of your project
2. Create and configure Google Tag Manager and Google Analytics Accounts
3. Setup GA4 Data Stream
4. Install GA4 Hardcoded measurement in your project
5. Install the GTM Manager Code
6. Create a GA4 Configuration Tag in GTM
7. Do the Additional Setup of GA4 if needed
8. Set up DataLayer if needed
9. Set up the configuration to send events
   * Send critical events by pushing them in the dataLayer
   * Send non-critical events using Recommended Events and Custom Events

## Events

Events are the core of GA, they're essentially actions happening on our website or on our app by our users. Those actions are then processed and aggregated by GA and shown in **reports**.

### Recommended Events

They are **predefined** by Google with **fixed names and parameters** (e.g., `purchase`, `login`, `search`). They aren't automatically tracked, but Google _recommends_ you implement them because GA4 knows how to interpret and report on them in standard reports.

To add them, configure GTM and you will see them in your reports.

### Custom and DataLayer Events

When the predefined **recommended events** do not cover your specific use case, you can create **custom events**.
Custom events allow you to define your own event names and parameters that better reflect the actions users take on your website or app. Examples include `newsletter_signup`, `video_played`, or `form_error`.

The most reliable way to send these events is through the **Data Layer** and **Google Tag Manager (GTM)**:

1. **Push the event to the Data Layer**
   Add a JavaScript snippet to your site or app that pushes the event when the action occurs:
   ```js
   dataLayer.push({
     event: "newsletter_signup",
     user_email: "user@example.com",
     signup_source: "homepage"
   });
   ```
2. Capture the event in GTM
3. **Validate the implementation**
   - Use **GTM Preview Mode** to confirm the event is firing.
   - Check **GA4 DebugView** to verify the event and its parameters are received correctly.
4. **Use in reporting**
   Once published, GA4 will start collecting the event.
   - Custom events appear under **Reports → Engagement → Events**.
   - Parameters can be registered as **custom dimensions or metrics** to make them available in standard and custom reports.

## Conversions setup (Key Events)

[Create or Modify Key Events - Official Doc](https://support.google.com/analytics/answer/12844695?hl=en)

In GA4, conversions are events you mark as **key business actions** (like purchases or sign-ups); they are important because they measure goal achievement and are used to optimize reports and linked ad platforms (e.g. Google Ads).

There is a set of events which are by default created and marked as *conversion* (e.g. `first visit` or `purchase`).
You can set them by going to `Admin > Data Display > Events`. You will see 2 lists: `Events` that contain all the events you collected and `Key Events` that aren't already set up.

### Purchase - Default Key Event

The `Purchase` event is the most striking conversion event, so GA4 automatically gets it as a **key event** and you can't unmark it.

### Set Existing Event as Key Event

By going to `Admin > Data Display > Events` and selecting `Recent Events` list, you can see all the 100 most recent events your GA4 has received. To mark one of them as **key event**, just click on the **star icon on the left** in the row of the event you choose.

### Key Event Value

In Google Analytics key events, the **`value` parameter** represents the numerical worth associated with an interaction, such as the total price of a purchase or the monetary equivalent of a conversion. It is important because it allows GA4 to measure not just *how often* events happen, but also their **business impact**, enabling accurate revenue reporting, ROI calculations, and ad optimization.

By default, GA4 gets the `value` parameter of the event as its **economic value**. You can modify the value by going to `Admin > Data Display > Events > 3 dot on Purchase > Set default key event value`.

## Note e benchmark

- GA4 is event-based, not session-based like Universal Analytics
- Always configure enhanced measurement for automatic tracking of scrolls, outbound clicks, site search, video engagement, and file downloads
- Use the GA4 Demo Account for testing before making changes to production properties
