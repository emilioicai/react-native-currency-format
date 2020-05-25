# react-native-currency-format

## Getting started

`$ yarn add react-native-currency-format`

### iOS Only

`$ cd ios && pod install`

## Usage

```javascript
import CurrencyFormatter from "react-native-currency-format";

const price = 1234.56;
const currency = "EUR";
const formattedPrice = await CurrencyFormatter.format(price, currency);
console.log(formattedPrice); // "1.234,56 €"
```
