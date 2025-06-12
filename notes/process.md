# Mood Ring Project

### Requirements:
- There should be a homepage
  - Should have a title (i.e."Mood Ring") and description
- There should be a way to navigate to pages representing different colors (minium of the three primary colors)
- Color Pages
  - Should have a title that corresponds to the color
  - Should have a background that matches the color
  - Should feature a description with a "mood word" that matches the mood of the color (i.e. yellow -> happy) 
    - The mood word should cycle on page reload

### Refactor Requirements:
- Step 1: Create a new route that can accept a dynamic value for color in the url (i.e. mypage.com/color/red or mypage.com/color/yellow)
- Step 2: Create a variable that lets us keep track of whatever value is input as the color in the URL
- Step 3: Create one erb file for all colors
- Step 4: Add logic to the get block to conditionally display mood words based on the primary color passed into the parameters
- Step 5: To the dynamic erb file, use dynamic values to pass in a heading with the color name and dynamic mood word description
- Step 6: Make sure the background changes to match the params color

### Adding a Form
- Step 1: Add a select form to the homepage (where? erb? route?)
  - Figure out how to make a form
  - Figure out how to format a select form
- Step 2: Create form action logic route (what type of request will this be?)

### Check your Comprehension:

We'll use **Ruby with Sinatra** to build this project.

Core Concepts to practice:
- **Routes:** Creating paths like `/`, `/red`, `/blue` that trigger different pages
- **Views:** Using `.erb` files to show each page visually
- **Dynamic content:** Using Ruby logic to randomly choose mood words
- **Instance variables:** Passing data from the route to the view
- **Layout file:** Using a layout file for shared headers and navigation. 

Stretch Concepts to practice:
- **Dynamic Routes:** Add an input form that lets users select a color
- **Forms:** Add an input form that lets users select a color
- **Query parameters:** Add query params like `/mood?color=yellow`
- **Service Objects:** Create a service object to handle selecting a random mood word
