import 'package:guinness/guinness.dart';
import 'package:tickets/shared/schemas.dart';

import '../bin/ticketing_model.dart';

main() {
  TicketingModel model = new TicketingModel();

  Map postPurchase = { "bAddress": "Consequatur amet possimus nulla et consectetur et",
    "bCity": "Ad aliqua Possimus dolor est iusto sequi quis officia laboris eos",
    "bCountry": "Est numquam nostrum est alias voluptatum corporis numquam voluptas exercitationem consequatur voluptas irure quas commodi est blanditiis",
    "bFirstName": "Dean",
    "bLastName": "Woodard",
    "bMiddleName": "Xaviera Henson",
    "bState": "Az",
    "bZip": '12',
    "ccExpiration": "Sint enim architecto commodi perferendis expedita quisquam quam cupidatat",
    "ccType": "visa",
    "ccn": '8',
    "ccv": '38',
    "flightID": 1006,
    "flightLevel": 3,
    "pEmail": "mohezizova@gmail.com",
    "pFirstName": "Mara",
    "pLastName": "Zimmerman",
    "pMiddleName": "Keegan Lee" };

  describe('Ticketing Model', () {

    it("should create a purchase object", () async {
      return model.createPurchase(postPurchase).then((PurchaseDTO confirmation){
        expect(confirmation.collection_key).toBe('Purchases');
      });
    });

    it("should get all cities", () async {
      return model.getAllCities({}).then((List cities){
        expect(cities.length).toBeGreaterThan(4);
      });
    });

    it("should get all times", () async {
      return model.getAllTimes({}).then((List times){
        expect(times.length).toBeGreaterThan(10);
      });
    });

    var timesPost = {"cityDepart":"SFO","cityArrival":"SAN","dateDepart":"2015-12-31"};
    it("Should get times based on arrival and departure city", () {
      return model.getTimesByCity(timesPost).then((List<TimeDTO> dtos){
        expect(dtos.first.flight).toBe(1016);
      });
    });

    it("should return the time for the flight number", () async {
        return model.getTimesByFlightNumber({'flight': '1016'}).then((List<TimeDTO> times){
          expect(times.first.takeoff).toBe(1000);
        });
    });
  });
}
