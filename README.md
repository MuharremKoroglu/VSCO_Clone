# VSCO
### Hi there, I'm Muharrem <img src = "https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width = "42"> 
#### Thank You for taking the time to view my repository 

## <h2> About This App <img src = "https://c.tenor.com/JsoERRQcZqYAAAAi/thumbs-up-joypixels.gif" width = "42"></h2>
This application is a clone of the popular VSCO application today. With this app, you can learn how to log in with Google using Firebase and how to use CollectionView class. On the login screen of the application, one TextField and four buttons welcome you. Here, if the user has previously registered and confirmed his e-mail address, he must enter his e-mail address and password using the TextField structures. Then he can log into the app if he didn't type it wrong. If the user is to register for the first time, we direct him to the registration screen with the Sign Up button. Here, we want the profile photo of the user and his/her username, e-mail, and password information. This requested information is saved to Firebase using FirebaseFirestore and FirebaseStorage. You can see an ActivityIndicatorView on the screen until the registration process is complete. It disappears from the screen when the process is complete. After the user is created, the user still cannot log in. For application security, the user is asked to verify their e-mail address. In this way, a confirmation e-mail is sent to the user. If approved, he can now log in. If the user forgets his password, he clicks the Forgot Password button. On the page that opens, the user is expected to enter his e-mail address. When the reset password button is clicked, a password reset link will be sent to the user's e-mail address and the user can now reset their password. The most important point we should mention on the login screen is logging in with Google. When the user clicks this button, the Sign In with Google screen opens. If the user logs in with his google account, he logs into the application directly and his account is created automatically. The google account information of the users who log in with this method is taken with certain methods and displayed on the Account page. There is also a sign-out button on this page. With this button, the user can successfully exit the application. When the user successfully logs into the application, a TabBAr greets the user at the bottom of the screen. Here we have three home screens. The first is Home, the second is Upload, and the third is Account. Let's start with the account screen. This screen retrieves the user information generated from FirebaseFirestore and displays the user information on the screen. In this way, the user can see their information. The user can also log out of the application at any time with the Log Out button under his information. Our second screen, Upload, work with advanced Firebase techniques. Here, first of all, it is checked whether the user has shared anything before. If so, the received post and comment are saved in an array. In this way, instead of creating different posts, we show the same posts to the user by scrolling. On the home screen, we use a CollectionView structure. Here, first of all, we take the information of the logged-in user into our application with the Singleton we created and use them in the application where necessary. Then, we receive the post information sent by the user with the model we have created. In this way, we provide an easier and cleaner code flow. I just want to draw your attention here that we calculate how much the user's post is different from the current time. In this way, posts that have completed 24 hours are deleted from Firebase. When the user clicks on the posts, the post screen opens. Here, with the ImageSlider package, we show the user's posts and comments to the user. In addition, thanks to the method we added, as the user scrolls, the index of the picture on the screen is taken and the comment specific to that picture is displayed. As you can see on the same screen, you can see the remaining time of the post and who created it. Finally, we have used many ActivityIndicatorView structures to show whether the transaction process with Firebase is finished. In addition, we have written a more organized code by working with models and Singleton structures.

<a href="https://github.com/zvonicek/ImageSlideshow" target="_blank">Visit ImageSlideShow</a><br>


<h2> Used Technologies <img src = "https://media2.giphy.com/media/QssGEmpkyEOhBCb7e1/giphy.gif?cid=ecf05e47a0n3gi1bfqntqmob8g9aid1oyj2wr3ds3mg700bl&rid=giphy.gif" width = "42"> </h2>
<div class="row">
      <div class="column">
<img width ='72px' src 
     ='https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/swift-icon.svg'>
  </div>
</div>

<h2> Used Language <img src = "https://media.giphy.com/media/Zd6jPg8hcp4Q3vrvjo/giphy.gif" width = "42"> </h2>
<div class="row">
      <div class="column">
<img width ='82px' src 
     ='https://upload.wikimedia.org/wikipedia/commons/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg'>
  </div>
</div>

<h2> Images <img src = "https://media2.giphy.com/media/psneItdLMpWy36ejfA/source.gif" width = "62"> </h2>
  <div class="column">




https://user-images.githubusercontent.com/68854616/213765295-428daf35-d7cb-4ec8-bbf7-bb65f610a5d6.mp4








  </div>
<h2> Connect with me <img src='https://raw.githubusercontent.com/ShahriarShafin/ShahriarShafin/main/Assets/handshake.gif' width="100"> </h2>
<a href = 'mailto:muharremkoroglu245@gmail.com'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/gmail-logo-2561.svg"/></a> &nbsp;
<a href = 'https://www.linkedin.com/in/muharremkoroglu/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/rahulbanerjee26/githubAboutMeGenerator/main/icons/linked-in-alt.svg"/></a> &nbsp;
<a href = 'https://muharremkoroglu.medium.com/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/rahulbanerjee26/githubAboutMeGenerator/main/icons/medium.svg"/></a> &nbsp;
<a href="https://www.instagram.com/m.koroglu99/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="_._.adam._"  width="32px" align= 'center' /></a> &nbsp;
<a href = 'https://synta-x.com/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/internet-svgrepo-com%20(2).svg"/></a> &nbsp;
























