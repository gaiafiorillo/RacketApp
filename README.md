# Concert Finder App

This project is a group effort to create an app that connects fans of live music with concerts and events. Fans can search for upcoming concerts, while bands and artists can post concert listings. The app is developed in Racket, using a graphical user interface (GUI) for interaction.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Data Structure](#data-structure)
- [Algorithms](#algorithms)
- [User Interface](#user-interface)
- [Team Contributions](#team-contributions)
- [License](#license)

## Introduction

The Concert Finder App is designed for two main types of users: **bands/artists** and **fans**. Bands can post concerts, while fans can search and save events to their favorites. This app is built with Racket and uses a GUI for a seamless user experience.

## Features

- **Account Creation**: Users can create accounts as either a band or a fan.
- **Concert Listings**: Bands can create, edit, and manage their concert listings.
- **Search Functionality**: Fans can search for concerts by band name or venue.
- **Favorites**: Fans can save concerts to their favorites and remove them later.
- **Concert Availability**: Bands can update their listings to show if a concert is fully booked or canceled.


## Installation

1. **Clone the repository**:

   ```
   git clone https://github.com/gaiafiorillo/RacketApp.git
   ```

2. **Navigate to the project directory**:

   ```
   cd RacketApp
   ```

3. **Install Racket** (if not installed already):
   
   Follow the instructions for your platform here: [Racket Installation](https://racket-lang.org/).

4. **Run the application**:

   In the terminal, run:

   ```
   racket Project_Draft_Update.rkt
   ```

---

### Prerequisites

- DrRacket IDE or any Racket-compatible environment

### Running the App

1. Open the `Project_Draft_Update.rkt` file in DrRacket.
2. Click the **Run** button to start the app.

## Usage

Once the app is running, users can:

- **Fans**: 
  - Sign up as a fan.
  - Search for concerts by band name or venue.
  - Add concerts to their favorites.
  - View and remove concerts from their favorite list.
  
- **Bands**:
  - Sign up as a band.
  - Create, edit, and update concert listings.
  - Change the availability of the concert (e.g., canceled or fully booked).

## Data Structure

### Users

- **Fans**: Stored in sets to ensure that usernames are unique.
- **Bands**: Stored in sets to ensure that usernames are unique.
  
### Concert Listings

- **Concerts**: Stored in lists to allow for dynamic updates of the concert data, which includes information such as band name, date, venue, and cost.

## Algorithms

The app provides search functionality where:

- Fans can search for concerts based on the band name or venue.
- The search results display all relevant concerts, including their details (band name, date, time, venue, cost).
  
If no results are found, an "Invalid Search" message is returned.

## User Interface

The app features a graphical user interface (GUI) where:

- **Fans**: Can search concerts, view favorites, and browse available listings.
- **Bands**: Can manage their concert listings and update the status of their events (e.g., fully booked or canceled).



## Team Contributions

| Team Member               | Contribution                                                                        |
|---------------------------|-------------------------------------------------------------------------------------|
| **Lee**     | Created the structure and code for the fan's data, favorites list, and contributed to the report. |
| **Gaia**    | Developed the graphical user interface (GUI) and integrated all components.                       |
| **Sell**    | Implemented the search functionality and detailed the algorithms in the report.                   |
| **Elysia**  | Developed the code for concert listings, including managing status updates.                       |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

