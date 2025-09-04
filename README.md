- At a high level, how does your app work?

  The app is developed in swift UI with MVVM architecture pattern. And it is a single view shown at this time on launch with Nav title, and no data screen initially and a search bar field at the top
  When a text entered in the search bar then it uses a service to make an API call to OMDB site and fetch only title, image url and rating
  It displays title, image (downloaded using AsyncImage) and star rating normalized to 5 stars based on imdbRating
  
- What design decisions did you make and why?

  MVVM is pretty straight forward and clean with swiftUI
  
- What documentation, websites, papers, etc. did you consult for this assignment?

  Accessibility I did long time ago so had to read some article in Voice over: https://www.kodeco.com/books/swiftui-cookbook/v1.0/chapters/2-add-voiceover-to-swiftui-views
  For converting (ceiling/flooring) the float value used the inbuilt api on Float type : Rounding imdbRating: https://developer.apple.com/documentation/swift/floatingpointroundingrule/tonearestorawayfromzero
  Spent all 3 hours. 80% work done in 20% to 30% of the time. Remaining in doing some trial and errros in Testing View model for both success and failure newwork calls
  And spent some time on AsnycImage and paddings etc. Still more room for refinement.
  Avoided try catches for newtwork calls, httpresponse code and also enum with all possible errors. Added //TODO: comments where more work can be done
  Accessibility for reading star rating is working but it browse thru each star. Need to group all stars into single group and need some effort on that.
  
- What third-party libraries or other tools does your application use? How did you choose each library or framework you used?

  No third party frameworks used
  
- How long did you spend on this exercise? If you had unlimited time to spend on this, how would you spend it and how would you prioritize each item?
  
  3 hours + git setup and time to write this ReadMe Doc.

- If you were unable to finish the exercise, what issues did you face and how did you plan on finishing the exercise

  App runs and minimum requirement of fetching movie information works fine with displaying title, image and rating as per the requirement and also No data message if nothing received from IMDB
  As requirement specified tests added for rating to check floor/ceiling the values and also checking network success/failure validation on ViewModel.fetchMovie data calls
