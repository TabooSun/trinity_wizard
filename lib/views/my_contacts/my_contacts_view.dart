import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/views/my_contacts/my_contacts_view_model.dart';

class MyContactsView extends StatefulWidget {
  const MyContactsView({
    super.key,
  });

  @override
  _MyContactsViewState createState() => _MyContactsViewState();
}

class _MyContactsViewState extends State<MyContactsView> {
  final MyContactsViewModel vm = Get.find<MyContactsViewModel>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contacts',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: <Widget>[
          const _SearchForm(),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                await vm.fetchContacts(
                  searchTerm: '',
                );
              },
              child: Obx(() {
                return GridView.builder(
                  itemCount: vm.contacts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 29,
                    vertical: 25,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final UserDto contact = vm.contacts[index];
                    return _ContactItem(
                      contact: contact,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatefulWidget {
  const _ContactItem({
    // ignore: unused_element
    super.key,
    required this.contact,
  });

  final UserDto contact;

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  final MyContactsViewModel vm = Get.find<MyContactsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color(0xffcccccc),
        ),
      ),
      child: InkWell(
        onTap: () {
          vm.editContact(
            contact: widget.contact,
          );
        },
        child: Column(
          children: <Widget>[
            const SizedBox(height: 12),
            SizedBox.square(
              dimension: 112,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xff0077b6),
                ),
                child: Center(
                  child: Text(
                    (widget.contact.firstName[0] + widget.contact.lastName[0])
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: '${widget.contact.firstName} ${widget.contact.lastName}',
                children: <InlineSpan>[
                  if (vm.checkIsMe(user: widget.contact))
                    const TextSpan(
                      text: ' (you)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff7f7f7f),
                      ),
                    ),
                ],
              ),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchForm extends StatefulWidget {
  const _SearchForm({
    // ignore: unused_element
    super.key,
  });

  @override
  State<_SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<_SearchForm> {
  final MyContactsViewModel vm = Get.find<MyContactsViewModel>();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      vm.fetchContacts(
        searchTerm: _searchController.text,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Color(0xffcccccc),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search your contact list...',
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff7f7f7f),
          ),
          suffixIcon: Icon(Icons.search),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
        ),
      ),
    );
  }
}
