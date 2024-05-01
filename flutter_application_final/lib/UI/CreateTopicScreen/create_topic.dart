import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/ScanDocumentScreen/scan_document.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';
import 'package:flutter_application_final/bloc/CreateTopicBloc/create_topic_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTopic extends StatefulWidget {
  const CreateTopic({super.key});

  @override
  State<CreateTopic> createState() => _CreateTopicState();
}

class _CreateTopicState extends State<CreateTopic> {
  TextEditingController classNameController = TextEditingController();
  TextEditingController classDescriptionController = TextEditingController();
  bool er1 = false, isPrivate = false;
  final CreateTopicBloc createTopicBloc = CreateTopicBloc();

  @override
  void initState() {
    createTopicBloc.add(CreateTopicEventInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTopicBloc, CreateTopicState>(
        bloc: createTopicBloc, 
        listenWhen: (previous, current) => current is CreateTopicActionState,
        buildWhen: (previous, current) => current is! CreateTopicActionState,
        listener: (context, state) {
          print("$state listen");
          if (state is CreateTopicScanDocumentClick) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScanDocument()));
          }
        },
        builder: (context, state) {
          print("$state builder");
          switch (state.runtimeType) {
            case CreateTopicIsSuccess:
              final successState = state as CreateTopicIsSuccess;
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  title: const Text(
                    "Tạo chủ đề mới",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  actions: [
                    IconButton(
                        onPressed: () {
                          createTopicBloc.add(ClickCompleteButtonEvent());
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      MyTextField(
                        controller: classNameController,
                        labelText: "Tên chủ đề",
                        error: er1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              createTopicBloc.add(ClickScanDocumentButtonEvent());

                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Thêm tài liệu",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Row(children: [
                            Switch(
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.green,
                              value: isPrivate, onChanged: (value){
                                setState(() {
                                  isPrivate = !isPrivate;
                                });
                              }),
                            const Text("Chỉ mình tôi", style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),),
                          ],)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: successState.count,
                            itemBuilder: (context, index) {
                              return addTerm();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    createTopicBloc
                        .add(ClickFloattingButtonEvent(count: successState.count));
                  },
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      );
  }

  Widget addTerm() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text("Từ vựng"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text("Định nghĩa"),
            ),
          ),
        ],
      ),
    );
  }
}
