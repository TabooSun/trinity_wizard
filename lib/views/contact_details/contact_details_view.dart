import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/theme/app_colors.dart';
import 'package:trinity_wizard/views/contact_details/contact_details_view_model.dart';
import 'package:trinity_wizard/widgets/form_field_label.dart';

class ContactDetailsView extends StatefulWidget {
  const ContactDetailsView({
    super.key,
  });

  @override
  _ContactDetailsViewState createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<ContactDetailsView> {
  final ContactDetailsViewModel vm = Get.find<ContactDetailsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Details',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Obx(() {
              final UserDto? contact = vm.contact.value;
              if (contact == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox.square(
                dimension: 100,
                child: DecoratedBox(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Color(0xff0077b6),
                  ),
                  child: Center(
                    child: Text(
                      (contact.firstName[0] + contact.lastName[0])
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 47,
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              UserDto? contact = vm.contact.value;
              if (contact == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return _Form(
                contact: contact,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    // ignore: unused_element
    super.key,
    required this.contact,
  });

  final UserDto contact;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final ContactDetailsViewModel vm = Get.find<ContactDetailsViewModel>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text = widget.contact.firstName;
    _lastNameController.text = widget.contact.lastName;
    final String? email = widget.contact.email;
    if (email != null) {
      _emailController.text = email;
    }
    final String? dob = widget.contact.dob;
    if (dob != null) {
      _dobController.text = dob;
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _FormHeader(
            title: 'Main Information',
          ),
          const FormFieldLabel(
            title: 'First Name',
            isRequired: true,
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              hintText: 'Enter your first name',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.primary,
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          const FormFieldLabel(
            title: 'Last Name',
            isRequired: true,
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(
              hintText: 'Enter your last name',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.primary,
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const _FormHeader(
            title: 'Sub Information',
          ),
          const FormFieldLabel(
            title: 'Email',
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              prefixIcon: const Icon(
                Icons.email,
                color: AppColors.primary,
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          const FormFieldLabel(
            title: 'Date of Birth',
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
            controller: _dobController,
            decoration: InputDecoration(
              hintText: 'Enter your date of birth',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7f7f7f),
              ),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
            ),
          ),
          const SizedBox(
            height: 165,
          ),
          SizedBox(
            width: double.infinity,
            height: 53,
            child: TextButton(
              onPressed: () {
                vm.updateContact(
                  id: widget.contact.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  dob: _dobController.text,
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color(0x1A96D3F2),
                foregroundColor: AppColors.primary,
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 27,
          ),
          SizedBox(
            width: double.infinity,
            height: 53,
            child: OutlinedButton(
              onPressed: () {
                vm.removeContact(
                  id: widget.contact.id,
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.red,
                side: const BorderSide(
                  color: Colors.red,
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 27,
          ),
        ],
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader({
    // ignore: unused_element
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 22.5 / 15,
            fontStyle: FontStyle.italic,
            color: Color(0xff0077b6),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        const Divider(
          thickness: 0.5,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
