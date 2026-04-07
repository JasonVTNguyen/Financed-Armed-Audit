extends Node

var tutorials : Dictionary[String, Tutorial] = {
	"BeginningTutorial0" : Tutorial.new("BeginningTutorial0","Grandpa's Notes","To my grandson, One day you may find yourself strapped for cash. It's a bird-eat-bird world out there, so I leave you the secrets to my fishing techniques."),
	"BeginningTutorial1" : Tutorial.new("BeginningTutorial1","How to Fish","Of course, fishing starts how you normally would. Cast your fishing line to where fish are and they'll slowly approach your fishing hook."),
	"BeginningTutorial2" : Tutorial.new("BeginningTutorial1","How to Fish (2)","Once they get really close, surprise them with a sudden but smooth pull to send them right out of the water! Forget that 'wait until they take a bite' nonsense."),
	"BeginningTutorial3" : Tutorial.new("BeginningTutorial2","How to Shoot","Now that they're in the air, it's time to use that other thing I left you. Point at the fish and press the trigger. Repeat that and they'll drop dead in no time."),
	"BeginningTutorial4" : Tutorial.new("BeginningTutorial3","How to Shoot (2)","Of course, you gotta practice some control. After all, ammunition ain't exactly easy to come across nowadays. You can use what I've left for you to reload that gift, but you gotta find a supplier at some point."),
	"BeginningTutorial5" : Tutorial.new("BeginningTutorial3","Grandpa's Notes End","I hope you will make use of this final gift from me, as I wish you the best in your path as a fisherbird. As for me, I've moved on to the Tropical Isles to live out the rest of my days, please visit when you have the chance."),
}

var tutorial_beginning : Array[String] = ["BeginningTutorial0","BeginningTutorial1","BeginningTutorial2","BeginningTutorial3","BeginningTutorial4","BeginningTutorial5"]
