
    flightid = ""
    def __init__(self):
        super(FlightWindow,self).__init__()
        uic.loadUi(path + "//UI//flightdetails.ui",self)

        self.actionPassenger_Details_2.triggered.connect(self.passengerMenuSelected)
        self.actionAircraft_Details_2.triggered.connect(self.aircraftMenuSelected)
        self.actionAirport_Details_2.triggered.connect(self.airportMenuSelected)

        self.actionAdmin_Logout.triggered.connect(self.backtoLogin)

        self.flightnumberinput.editingFinished.connect(self.entersFlight)

        #buttonsFunctionality
        self.ViewPassengers.clicked.connect(self.viewFlightPassengers)
        self.ViewMealServed.clicked.connect(self.viewFlightMeal)
        self.ViewFlightCrew.clicked.connect(self.viewCrewMembers)

    def entersFlight(self):
        self.flightid = self.flightnumberinput.text()
        tup = ViewFlightRecord(self.flightid)
        self.Airline.setText("Airline: " + tup[0][0])
        if tup[1] == 'a':
            prnt = "Estimated Time of Arrival: " + tup[0][1]
            strng = "From: " + tup[0][2]
        else:
            prnt = "Estimated Time of Departure: " + tup[0][1]
            strng = "To: " + tup[0][2]
        self.EstimatedTime.setText(prnt)
        self.FromTo.setText(strng)
        lugg = FetchLuggageCount(self.flightid)
        self.luggageCount.setText("Number of Luggage Bags: " + str(lugg))
        banday = FetchPassengerOnFlightCount(self.flightid)
        self.passengerCount.setText("Number of Passengers: " + str(banday))

    def viewFlightPassengers(self,checked):
        self.viewPassengersonPlane = viewFlightPassengersWindow(self.flightid)
        self.viewPassengersonPlane.show()

    def viewFlightMeal(self,checked):
        self.viewMealsonPlane = viewMealServedWindow(self.flightid)
        self.viewMealsonPlane.show()

    def viewCrewMembers(self,checked):
        self.viewCrewOnPlane = viewCrewMemberWindow(self.flightid)
        self.viewCrewOnPlane.show()

    def passengerMenuSelected(self,checked):
        SwitchWindows.openPassengerWindow(self)

    def airportMenuSelected(self,checked):
        SwitchWindows.openAirportWindow(self)
    
    def aircraftMenuSelected(self,checked):
        SwitchWindows.openAircraftWindow(self)

    def backtoLogin(self,checked):
        SwitchWindows.openLoginWindow(self)


#Passenger Class
