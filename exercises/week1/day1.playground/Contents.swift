import UIKit

let dayHours = 8.0
let monthDays = 22.0

func getDiscount(discount: Double) -> Double{
    return (100.0 - discount) / 100
}

func dailyRateFrom(hourlyRate: Int) -> Double{
    return Double(hourlyRate) * dayHours
}
print(dailyRateFrom(hourlyRate: 60))


func monthlyRateFrom(hourlyRate: Int, withDiscount: Double) -> Double{
    let monthlyRate = dailyRateFrom(hourlyRate: hourlyRate) * monthDays
    return round(monthlyRate * getDiscount(discount: withDiscount))
}
print(monthlyRateFrom(hourlyRate: 77, withDiscount: 10.5))


func workdaysIn(budget: Int, hourlyRate: Int, withDiscount: Double) -> Double{
    let dailyWithDiscount = dailyRateFrom(hourlyRate: hourlyRate) * getDiscount(discount: withDiscount)
    return round(Double(budget) / dailyWithDiscount)
}
print(workdaysIn(budget: 20000, hourlyRate: 80, withDiscount: 11.0))

//
let months = 12.0 * 5.0
func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String{
    let monthsPrice = price / months
    if monthsPrice <= monthlyBudget {
        return "Yes! I'm getting a \(vehicle)"
    } else if monthsPrice <= monthlyBudget * 1.1 {
        return "I'll have to be frugal if I want a \(vehicle)"
    } else {
        return "Darn! No \(vehicle) for me"
    }
}
print(canIBuy(vehicle: "1974 Ford Pinto", price: 516.32, monthlyBudget: 100.00))
print(canIBuy(vehicle: "2011 Bugatti Veyron", price: 2_250_880.00, monthlyBudget: 10000.00))
print(canIBuy(vehicle: "2020 Indian FTR 1200", price: 12_500, monthlyBudget: 200))


func licenseMessage(license: String) -> String{
    return "You will need a \(license) license for your vehicle"
}

func licenseType(numberOfWheels: Int) -> String{
    switch numberOfWheels {
    case 2,3:
        return licenseMessage(license: "motorcycle")
    case 4,6:
        return licenseMessage(license: "automobile")
    case 18:
        return licenseMessage(license: "commercial trucking")
    default:
        return "We do not issue licenses for those types of vehicles"
    }
}

print(licenseType(numberOfWheels: 2))
print(licenseType(numberOfWheels: 6))
print(licenseType(numberOfWheels: 18))
print(licenseType(numberOfWheels: 0))

func registrationFee(msrp: Int, yearsOld: Int) -> Double{
    if yearsOld >= 10 {
        return 25.0
    }
    let bestCost = max(msrp, 25000)
    let depreciation = Double(msrp) * 0.1 * Double(yearsOld)
    return floor((Double(bestCost) - depreciation) / 100.0)
}
print(registrationFee(msrp: 2250800, yearsOld: 9))
print(registrationFee(msrp: 25000, yearsOld: 3))
print(registrationFee(msrp: 34000, yearsOld: 30))
