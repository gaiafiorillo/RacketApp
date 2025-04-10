# Concert Finder App

This **Concert Finder App** connects fans with live music events. Fans can search for upcoming concerts, and bands/artists can post their concert listings. Developed in Racket, the app uses a graphical user interface (GUI) for smooth interaction.

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

The app has two types of users: **bands/artists** and **fans**. Bands can post their concerts, while fans can search for events and save them to their favorites. The app is built using Racket and includes a GUI for easy navigation.

## Features

- **Account Creation:** Users can sign up as either a band or a fan.
- **Concert Listings:** Bands can create, edit, and manage their concert listings.
- **Search Functionality:** Fans can search for concerts by band name or venue.
- **Favorites:** Fans can save concerts to their favorites and remove them later.
- **Concert Availability:** Bands can update concert status (e.g., sold out, canceled).

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/gaiafiorillo/RacketApp.git
   ```

2. Navigate to the project directory:

   ```bash
   cd RacketApp
   ```

3. Install Racket (if not already installed):  
   Follow the instructions for your platform here: [Racket Installation](https://racket-lang.org/).

4. Run the application:

   In the terminal, run:

   ```bash
   racket Project_Draft_Update.rkt
   ```

### Prerequisites
- DrRacket IDE or any Racket-compatible environment.

## Running the App

1. Open the `Project_Draft_Update.rkt` file in DrRacket.
2. Click the "Run" button to start the app.

## Usage

Once the app is running:

### Fans:
- Sign up as a fan.
- Search for concerts by band name or venue.
- Add concerts to favorites.
- View and remove concerts from your favorites list.

### Bands:
- Sign up as a band.
- Create, edit, and update concert listings.
- Update concert availability (e.g., canceled or fully booked).

## Data Structure

- **Users:**
  - Fans and Bands are stored in sets to ensure unique usernames.
- **Concert Listings:**
  - Concerts are stored in lists to allow dynamic updates, including details like band name, date, venue, and cost.

## Algorithms

- **Search Function:**  
  Fans can search concerts by band name or venue. The app returns matching results or an "Invalid Search" message if no matches are found.

## User Interface

The GUI allows for easy interaction:
- **Fans:** Search for concerts, view favorites, and browse listings.
- **Bands:** Manage concert listings and update the status of events (e.g., sold out or canceled).

## Team Contributions

| Team Member | Contribution |
|-------------|--------------|
| Lee         | Built the structure and code for fans’ data and favorites list, contributed to the report. |
| Gaia        | Developed the GUI and integrated all components. |
| Sell        | Implemented the search functionality and detailed the algorithms in the report. |
| Elysia      | Developed the code for concert listings and event status updates. |

## License

This project is licensed under the MIT License - see the LICENSE file for details.

