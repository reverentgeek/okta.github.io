---
layout: blog_post
title: 'Build a Health Tracking App with Electron, React, TypeORM, and User Authentication'
author: mraible
description: "Electron is framework for creating native desktop applications with web tech like JavaScript, HTML, and CSS. This article shows you how to get started with Electron, React, TypeORM, and Okta for User Authentication."
tags: [electron, react, typeorm, authentication, oidc, oauth]
tweets:
    - "Learn how to build a fitness tracking app with @electronjs and user authentication →"
    - "Build a Health Tracking App with Electron, React, and TypeORM #electronjs #reactjs #typeorm"
    - "Leverage OIDC and @okta to add authentication to your kick-ass @electronjs + @reactjs app →"
---

Electron is a framework for building cross-platform desktop applications with web technologies like JavaScript, HTML, and CSS. It was created for GitHub's Atom editor and has achieved widespread adoption since. There are several apps that I use that are built with Electron: Slack, Kitematic, and Visual Studio Code to name a few.

Electron 2.0 was released in early May, along with changes to the project to adhere to semantic versioning strictly. This is good news for developers because it means patch releases will be more stable and new features will come in new major versions. When open source projects use semantic versioning correctly, end users don't see breaking changes as often and are more productive.

In this article, I'll show you how to create an Electron app with React. You'll learn how to build a health tracking app using some cool TypeScript/JavaScript libraries, including TypeORM, GraphQL, and Express. Using OAuth and OIDC, you'll see how to add authentication to this app and secure it for your users.

Pretty much every application depends upon a secure identity management system. For most developers who are building Electron apps, there’s a decision to be made between rolling your own authentication/authorization or plugging in a service like Okta. Before I dive into building an Electron app, I want to tell you a bit about Okta, and why I think it’s an excellent solution for all JavaScript developers.

## What is Okta?

In short, we make [identity management](https://developer.okta.com/product/user-management/) a lot easier, more secure, and more scalable than what you’re used to. Okta is a cloud service that allows developers to create, edit, and securely store user accounts and user account data, and connect them with one or multiple applications. Our API enables you to:

* [Authenticate](https://developer.okta.com/product/authentication/) and [authorize](https://developer.okta.com/product/authorization/) your users
* Store data about your users
* Perform password-based and [social login](https://developer.okta.com/authentication-guide/social-login/)
* Secure your application with [multi-factor authentication](https://developer.okta.com/use_cases/mfa/)
* And much more! Check out our [product documentation](https://developer.okta.com/documentation/)

Are you sold? [Register for a forever-free developer account](https://developer.okta.com/signup/), and when you’re done, come on back so we can learn more about building secure Electron apps in React!

## Why a Health Tracking App

In late September through mid-October 2014, I'd done a 21-Day Sugar Detox during which I stopped eating sugar, started exercising regularly, and stopped drinking alcohol. I'd had high blood pressure for over ten years and was on blood-pressure medication at the time. During the first week of the detox, I ran out of blood-pressure medication. Since a new prescription required a doctor visit, I decided I'd wait until after the detox to get it. After three weeks, not only did I lose 15 pounds, but my blood pressure was at normal levels!

Before I started the detox, I came up with a 21-point system to see how healthy I was each week. Its rules were simple: you can earn up to three points per day for the following reasons:

1. If you eat healthy, you get a point. Otherwise, zero.
2. If you exercise, you get a point.
3. If you don't drink alcohol, you get a point.

I was surprised to find I got eight points the first week I used this system. During the detox, I got 16 points the first week, 20 the second, and 21 the third. Before the detox, I thought eating healthy meant eating anything except fast food. After the detox, I realized that eating healthy for me meant eating no sugar. I'm also a big lover of craft beer, so I modified the alcohol rule to allow two healthier alcohol drinks (like a greyhound or red wine) per day.

My goal is to earn 15 points per week. I find that if I get more, I'll likely lose weight and have good blood pressure. If I get fewer than 15, I risk getting sick. I've been tracking my health like this since September 2014. I've lost weight, and my blood pressure has returned to and maintained normal levels. I haven't had good blood pressure since my early 20s, so this has been a life changer for me.

I built [21-Points Health](https://www.21-points.com/#/about) to track my health. I figured it'd be fun to recreate a small slice of that app, just tracking daily points.

## Get Started with Electron and React

## Building an API with TypeORM, GraphQL, and Express

## Add Authentication with OIDC

### Source Code

You can find the source code for this article at https://github.com/oktadeveloper/okta-electron-react-example.

## Learn More About Electron, React, and Node

From React to an Electron app ready for production
Starts with Create React App, adds electron
https://medium.com/@kitze/%EF%B8%8F-from-react-to-an-electron-app-ready-for-production-a0468ecb1da3

Similar to above
https://medium.freecodecamp.org/building-an-electron-application-with-create-react-app-97945861647c

Just set up a working #GraphQL server in 40 lines of code:

https://twitter.com/michlbrmly/status/1001434883967930368

This article showed you how to build a secure Electron app with React, TypeORM, GraphQL, and Node/Express. I hope you enjoyed the experience!

At Okta, we care about making authentication with React and Node easy to implement. We have several blog posts on the topic, and documentation too! I encourage you to check out the following links:

* [Build User Registration with Node, React, and Okta](https://scotch.io/tutorials/add-user-registration-to-your-site-with-node-react-and-okta)
* [Build a React Application with User Authentication in 15 Minutes](https://developer.okta.com/blog/2017/03/30/react-okta-sign-in-widget)
* [Bootiful Development with Spring Boot and React](https://developer.okta.com/blog/2017/12/06/bootiful-development-with-spring-boot-and-react)
* [Add Okta authentication to your React app](https://developer.okta.com/code/react/okta_react)
* [Build a Basic CRUD App with Vue.js and Node](https://developer.okta.com/blog/2018/02/15/build-crud-app-vuejs-node)

I hope you have an excellent experience building apps with Electron and React. If you have any questions, please [hit me up on Twitter](https://twitter.com/mraible) or leave a comment below.