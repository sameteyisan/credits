### CREDITS

Show a simple end credits that includes any type of widgets as you wish.


<img  src="https://github.com/sameteyisan/credits/blob/main/example.gif?raw=true"  width="280">**&nbsp**<img  src="https://github.com/sameteyisan/credits/blob/main/example2.gif?raw=true"  width="280">

```dart
Credits(
	children: [
		Text("Actor 1"),
		Text("Actor 2"),
	],
),
```

That's it. ☺️ You can only use it by giving an ``children``.
```dart
Credits(
	onFinished: () => debugPrint("finish"),
	pauseOnTouch: false,
	duration: const  Duration(seconds: 12),
	delay: const  Duration(seconds: 1),
	children: [
		Text("Actor 1"),
		Text("Actor 2"),
		Text("Actor 3"),
	],
),
```

Parameters are as follows. ☺️

 - **children**: You have to give here the widgets that will be included in the scroll action.

 - **onFinished**: You can use this function for the operations to be performed when the scrolling process is completed.
 
 - **pauseOnTouch**: When the screen is pressed, it stops the credits.
 
 - **duration**: You can set the playing time of the swipe here.

 - **delay**: You can set the delay time of the scroll here.

 - **backgroundColor**: You can edit the background color here.

 - **curve**: Lets you specify the type of animation curve.

 - **crossAxisAlignment**: Lets you specify how children are placed along the cross axis in a flexible layout.
