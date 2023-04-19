## `exploClientId`

From the documentation, expoClientId is necessary when using the Expo Go app as Expo will be acting as a proxy for your authentication request. It is not the same as the Android or iOS client ids.

To generate the expoClientId for Google authentication, do the following on Google Cloud Platform:

    Create a new OAuth Client ID but set the type as Web Application.
    Set Authorized JavaScript origins to https://auth.expo.io
    Set Authorized redirect URIs to https://auth.expo.io/@{username}/{SLUG}. A complete example would be https://auth.expo.io/@abundance/MyExampleProject
    Use the generated Client ID as the expo client id.

You must be logged into the expo cli, and the SLUG can be found in the app.json file.
