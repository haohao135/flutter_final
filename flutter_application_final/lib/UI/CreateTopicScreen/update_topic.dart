import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/FireBase/create_word_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/word.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';
import 'package:flutter_application_final/bloc/CreateTopicBloc/create_topic_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class UpdateTopic extends StatefulWidget {
  UpdateTopic({super.key, required this.topic});
  Topic topic;
  @override
  State<UpdateTopic> createState() => _UpdateTopicState();
}

class _UpdateTopicState extends State<UpdateTopic> {
  late TextEditingController classNameController;
  bool er1 = false, isPrivate = false, isLoading = false;
  final CreateTopicBloc createTopicBloc = CreateTopicBloc();

  // ignore: unused_field
  final List<TextEditingController> _controllers1 = [];
  // ignore: unused_field
  final List<TextEditingController> _controllers2 = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    classNameController = TextEditingController(text: widget.topic.name);

    createTopicBloc
        .add(UpdateTopicEventInitial(count: widget.topic.listWords.length));
    for (int i = 0; i < widget.topic.listWords.length; i++) {
      _controllers1.add(TextEditingController(text: widget.topic.listWords[i].term));
      _controllers2.add(TextEditingController(text: widget.topic.listWords[i].definition));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTopicBloc, CreateTopicState>(
      bloc: createTopicBloc,
      listenWhen: (previous, current) => current is CreateTopicActionState,
      buildWhen: (previous, current) => current is! CreateTopicActionState,
      listener: (context, state) {
        // if (state is CreateTopicScanDocumentClick) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => const ScanDocument()));
        // }
      },
      builder: (context, state) {
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
                  "Chỉnh sửa chủ đề",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                actions: [
                  IconButton(
                      onPressed: () async {
                        if (classNameController.text.isEmpty) {
                          setState(() {
                            er1 = true;
                          });
                        } else {
                          setState(() {
                            er1 = false;
                          });
                        }

                        if (_formKey.currentState!.validate() && !er1) {
                          setState(() {
                            isLoading = true;
                          });
                          if (isLoading) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          List<Word> list = [];
                          for (var i = 0; i < widget.topic.listWords.length; i++) {
                            Word word = Word(
                                id: widget.topic.listWords[i].id,
                                term: _controllers1[i].text,
                                definition: _controllers2[i].text,
                                statusE: "notLearn",
                                isStar: false,
                                topicId: widget.topic.id);
                            await CreateWordFirebase.updateWord(word);
                            list.add(word);
                          }
                          if(widget.topic.listWords.length < successState.count){
                            for (var i = widget.topic.listWords.length; i < successState.count; i++) {
                            String id = const Uuid().v4();
                            Word word = Word(
                                id: id,
                                term: _controllers1[i].text,
                                definition: _controllers2[i].text,
                                statusE: "notLearn",
                                isStar: false,
                                topicId: widget.topic.id);
                            await CreateWordFirebase.createWord(word);
                            list.add(word);
                          }
                          }
                          Topic topic = Topic(
                              id: widget.topic.id,
                              name: classNameController.text,
                              mode: isPrivate,
                              author: FirebaseAuth.instance.currentUser!.email,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              listWords: list);
                          await CreateTopicFireBase.updateTopic(topic);
                          setState(() {
                            isLoading = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, "OK");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, "OK");
                        }
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
                        Row(
                          children: [
                            Switch(
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.green,
                                value: isPrivate,
                                onChanged: (value) {
                                  setState(() {
                                    isPrivate = !isPrivate;
                                  });
                                }),
                            const Text(
                              "Chỉ mình tôi",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: successState.count,
                            itemBuilder: (context, index) {
                              return addTerm(
                                  _controllers1[index], _controllers2[index]);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _controllers1.add(TextEditingController());
                  _controllers2.add(TextEditingController());
                  createTopicBloc.add(
                      ClickFloattingButtonEvent(count: successState.count));
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

  void createClick(int count) {}

  Widget addTerm(
      TextEditingController controller1, TextEditingController controller2) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Không được để trống";
              }
              return null;
            },
            controller: controller1,
            decoration: const InputDecoration(
              label: Text("Từ vựng"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Không được để trống";
              }
              return null;
            },
            controller: controller2,
            decoration: const InputDecoration(
              label: Text("Định nghĩa"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateWord(Word word) async{
    await CreateWordFirebase.updateWord(word);
  }
  Future<void> updateTopic(Topic topic) async{
    await CreateTopicFireBase.updateTopic(topic);
  }
}
