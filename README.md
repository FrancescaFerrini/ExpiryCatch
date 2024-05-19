# ExpiryCatch

ExpiryCatch is an iOS application designed to provide users with detailed food information by scanning barcodes. Its main goal is to help users prevent food waste through intuitive and practical features for managing food expiration dates. With knowledge of expiration dates, the app helps users effectively and responsibly manage their food, thus helping to reduce food waste and promoting more sustainable eating habits.

## Screenshots
<div align="center">
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/4c138413-4d23-4952-91d6-e2a313aeee58" width="250" />
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/9d3229e9-d7cf-4a4d-a6c3-64d4baa0f133" width="250" />
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/f9885ccb-afbd-4614-83be-25aa0ef7ddad" width="308" />
</div>


<div align="center">
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/69338597-5786-4f0f-9d60-94f83dc0bbd0" width="720" />
</div>

<div align="center">
     <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/e20ef6f4-ab18-49e7-8533-55a307cb673c" width="250" />
     <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/020cf6b4-c18c-4d11-a684-69d505dab2c2" width="250" />
</div>

<div align="center">
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/0aea1a8d-d54a-4391-83a5-20719f5f276d" width="250" />
    <img src="https://github.com/FrancescaFerrini/ExpiryCatch/assets/75753679/b540c91e-4d53-40bc-96d9-118fbe742152" width="250" />
</div>

## Main Features:

- **Onboarding**: The app presents an onboarding process to guide users through the main features of the app when they first start. During onboarding, users will learn how to scan barcodes, view product details, and save favorite products
- **Barcode scanner**: The app offers users the ability to scan barcodes on food products to get detailed information, such as product name, nutritional values, and nutriscore rating.
- **Viewing product details**: After scanning a barcode, the app displays product details, including product name, nutritional values, nutriscore rating, and expiration date. Users can also manually enter the products' expiration date.
- **Product saving**: Users can save their favorite products for quick access later.
- **Expiration date management**: It is possible to manually enter the expiration date of products and set reminders for products with impending expiration dates. In this way, the app will send notifications to users to remind them that the product is about to expire, thus preventing food waste.

## Future Implementation:
- **Receiving notifications based on mood**: In a future implementation, the app will include the ability for users to select a preferred mood from three options: "Calm," "Hot," and "Extreme." Based on the selected mood, users will receive personalized notifications that reflect the style and tone of the mood they select.


## Frameworks:

- **SwiftUI**: SwiftUI is Apple's framework for creating cross-platform user interfaces for iOS, macOS, watchOS, and tvOS.
In the project, SwiftUI is used for creating all application screens, including product details, onboarding, and mood selection screens.
- **UserNotifications**:UserNotifications is an Apple framework used for managing notifications to users on iOS and macOS devices.
It allows developers to send local and remote notifications to users, providing them with important information or reminders.
In the project, UserNotifications is used to send notifications to users to remind them of saved product deadlines and to provide custom notifications based on the selected mood
- **Combine**: Combine is Apple's framework for responsive programming in Swift.
It allows developers to easily manage asynchronous data streams, combine and transform data, handle errors, and handle events.
Combine makes it easy to handle asynchronous operations such as retrieving data from a Web API or handling user input.
In the project, Combine is used for asynchronous data flow management, such as loading images from URLs and retrieving data from the Open Food Facts API.

