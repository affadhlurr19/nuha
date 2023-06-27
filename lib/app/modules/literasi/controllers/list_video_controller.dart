import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/list_video_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/utility/result_state.dart';

class ListVideoController extends GetxController {
  final ListVideoProvider listVideoProvider;
  ListVideoController({required this.listVideoProvider});

  var resultState = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  RxInt tag = 1.obs;

  late ListVideo _listVideo;
  ListVideo get result => _listVideo;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (tag.value == 1) {
      getListVideo();
    }
  }

  Future<dynamic> getListVideo() async {
    try {
      final video = await listVideoProvider.getListVideo(http.Client());
      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        return _listVideo = video;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }
}
