# Mood Ring Project

### Requirements:
- There should be a homepage
  - Should have a title (Mood Ring) and description
- There should be a way to navigate to pages representing different colors (minium of the three primary colors)
- Color Pages
  - Should have a title that corresponds to the color
  - Should have a background that matches the color
  - Should feature a description with a "mood word" that matches the mood of the color (i.e. yellow -> happy) 
    - The mood word should cycle on page reload

### Check your Comprehension:

We'll use **Ruby with Sinatra** to build this project.

Core Concepts to practice:
- **Routes:** Creating paths like `/`, `/red`, `/blue` that trigger different pages
- **Views:** Using `.erb` files to show each page visually
- **Dynamic content:** Using Ruby logic to randomly choose mood words
- **Instance variables:** Passing data from the route to the view
- **Layout file:** Using a layout file for shared headers and navigation. 

Stretch Concepts to practice:
- **Forms:** Add an input form that lets users select a color
- **Query parameters:** Add query params like `/mood?color=yellow`
- **Service Objects:** Create a service object to handle selecting a random mood word
