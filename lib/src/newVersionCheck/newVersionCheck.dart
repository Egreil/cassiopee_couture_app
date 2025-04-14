import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

//Vérifie si une nouvelle version est disponible
import 'package:dio/dio.dart';

//Récupère l'URL du dernier APK disponible sur GitHub
Future<String> getLatestApkUrl() async {
  print("Récupération de l'URL du dernier APK");
  final response = await http.get(Uri.parse(
      'https://api.github.com/repos/Egreil/cassiopee_couture_app/releases/latest'));
  print(response.body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['assets'][0]
        ['browser_download_url']; // URL du premier fichier attaché
  } else {
    print("Erreur lors de la récupération de l'URL du dernier APK");
    return '';
  }
}

//Télécharge l'APK
Future<void> downloadApk(String url) async {
  print("Téléchargement de l'APK");
  Dio dio = Dio();
  String savePath =
      '/storage/emulated/0/Download/your_app.apk'; // Chemin d'enregistrement sur l'appareil

  try {
    await dio.download(url, savePath);
    print("APK téléchargé avec succès");

    // Ensuite, demande à l'utilisateur d'installer l'APK téléchargé
    installApk(savePath);
  } catch (e) {
    print("Erreur de téléchargement : $e");
  }
}

//Installe l'APK téléchargé
Future<void> installApk(String path) async {
  print("Installation de l'APK");
  final result = await OpenFile.open(path);
  if (result.type != ResultType.done) {
    print("Erreur lors de l'ouverture de l'APK pour l'installation");
  } else {
    print("L'APK a été lancé pour installation");
  }
}

//Demande de permission pour installer l'APK
Future<void> requestInstallPermission() async {
  print("Demande de permission pour installer l'APK");
  if (await Permission.requestInstallPackages.request().isGranted) {
    print("Permission d'installation obtenue");
  } else {
    print("Permission d'installation refusée");
  }
}

//Exécution des étapes
Future<void> executeSteps() async {
  final url = await getLatestApkUrl();
  if (url != '') {
    await requestInstallPermission();
    try {
      await downloadApk(url);
      await installApk(url);
    } catch (e) {
      print("Erreur lors de l'exécution des étapes : $e");
    }
  } else {
    print("Aucune URL trouvée");
  }
}
