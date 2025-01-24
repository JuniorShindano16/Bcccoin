import 'package:bcccoin/controllers/userController.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:bcccoin/utils/setting.dart';
import 'package:bcccoin/views/auth/visualisation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  bool _obscureText = true;
  bool _obscureTextc = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordVisibilityc() {
    setState(() {
      _obscureTextc = !_obscureTextc;
    });
  }

  final List<Map<String, String>> countryList = [
    {'country': 'Afghanistan', 'code': '+93'},
    {'country': 'Albania', 'code': '+355'},
    {'country': 'Algeria', 'code': '+213'},
    {'country': 'Andorra', 'code': '+376'},
    {'country': 'Angola', 'code': '+244'},
    {'country': 'Antigua and Barbuda', 'code': '+1-268'},
    {'country': 'Argentina', 'code': '+54'},
    {'country': 'Armenia', 'code': '+374'},
    {'country': 'Australia', 'code': '+61'},
    {'country': 'Austria', 'code': '+43'},
    {'country': 'Azerbaijan', 'code': '+994'},
    {'country': 'Bahamas', 'code': '+1-242'},
    {'country': 'Bahrain', 'code': '+973'},
    {'country': 'Bangladesh', 'code': '+880'},
    {'country': 'Barbados', 'code': '+1-246'},
    {'country': 'Belarus', 'code': '+375'},
    {'country': 'Belgium', 'code': '+32'},
    {'country': 'Belize', 'code': '+501'},
    {'country': 'Benin', 'code': '+229'},
    {'country': 'Bhutan', 'code': '+975'},
    {'country': 'Bolivia', 'code': '+591'},
    {'country': 'Bosnia and Herzegovina', 'code': '+387'},
    {'country': 'Botswana', 'code': '+267'},
    {'country': 'Brazil', 'code': '+55'},
    {'country': 'Brunei', 'code': '+673'},
    {'country': 'Bulgaria', 'code': '+359'},
    {'country': 'Burkina Faso', 'code': '+226'},
    {'country': 'Burundi', 'code': '+257'},
    {'country': 'Cabo Verde', 'code': '+238'},
    {'country': 'Cambodia', 'code': '+855'},
    {'country': 'Cameroon', 'code': '+237'},
    {'country': 'Canada', 'code': '+1'},
    {'country': 'Central African Republic', 'code': '+236'},
    {'country': 'Chad', 'code': '+235'},
    {'country': 'Chile', 'code': '+56'},
    {'country': 'China', 'code': '+86'},
    {'country': 'Colombia', 'code': '+57'},
    {'country': 'Comoros', 'code': '+269'},
    {'country': 'Congo (Congo-Brazzaville)', 'code': '+242'},
    {'country': 'Congo (Democratic Republic)', 'code': '+243'},
    {'country': 'Costa Rica', 'code': '+506'},
    {'country': 'Croatia', 'code': '+385'},
    {'country': 'Cuba', 'code': '+53'},
    {'country': 'Cyprus', 'code': '+357'},
    {'country': 'Czech Republic (Czechia)', 'code': '+420'},
    {'country': 'Denmark', 'code': '+45'},
    {'country': 'Djibouti', 'code': '+253'},
    {'country': 'Dominica', 'code': '+1-767'},
    {'country': 'Dominican Republic', 'code': '+1-809'},
    {'country': 'Ecuador', 'code': '+593'},
    {'country': 'Egypt', 'code': '+20'},
    {'country': 'El Salvador', 'code': '+503'},
    {'country': 'Equatorial Guinea', 'code': '+240'},
    {'country': 'Eritrea', 'code': '+291'},
    {'country': 'Estonia', 'code': '+372'},
    {'country': 'Eswatini', 'code': '+268'},
    {'country': 'Ethiopia', 'code': '+251'},
    {'country': 'Fiji', 'code': '+679'},
    {'country': 'Finland', 'code': '+358'},
    {'country': 'France', 'code': '+33'},
    {'country': 'Gabon', 'code': '+241'},
    {'country': 'Gambia', 'code': '+220'},
    {'country': 'Georgia', 'code': '+995'},
    {'country': 'Germany', 'code': '+49'},
    {'country': 'Ghana', 'code': '+233'},
    {'country': 'Greece', 'code': '+30'},
    {'country': 'Grenada', 'code': '+1-473'},
    {'country': 'Guatemala', 'code': '+502'},
    {'country': 'Guinea', 'code': '+224'},
    {'country': 'Guinea-Bissau', 'code': '+245'},
    {'country': 'Guyana', 'code': '+592'},
    {'country': 'Haiti', 'code': '+509'},
    {'country': 'Honduras', 'code': '+504'},
    {'country': 'Hungary', 'code': '+36'},
    {'country': 'Iceland', 'code': '+354'},
    {'country': 'India', 'code': '+91'},
    {'country': 'Indonesia', 'code': '+62'},
    {'country': 'Iran', 'code': '+98'},
    {'country': 'Iraq', 'code': '+964'},
    {'country': 'Ireland', 'code': '+353'},
    {'country': 'Israel', 'code': '+972'},
    {'country': 'Italy', 'code': '+39'},
    {'country': 'Jamaica', 'code': '+1-876'},
    {'country': 'Japan', 'code': '+81'},
    {'country': 'Jordan', 'code': '+962'},
    {'country': 'Kazakhstan', 'code': '+7'},
    {'country': 'Kenya', 'code': '+254'},
    {'country': 'Kiribati', 'code': '+686'},
    {'country': 'Korea (North)', 'code': '+850'},
    {'country': 'Korea (South)', 'code': '+82'},
    {'country': 'Kuwait', 'code': '+965'},
    {'country': 'Kyrgyzstan', 'code': '+996'},
    {'country': 'Laos', 'code': '+856'},
    {'country': 'Latvia', 'code': '+371'},
    {'country': 'Lebanon', 'code': '+961'},
    {'country': 'Lesotho', 'code': '+266'},
    {'country': 'Liberia', 'code': '+231'},
    {'country': 'Libya', 'code': '+218'},
    {'country': 'Liechtenstein', 'code': '+423'},
    {'country': 'Lithuania', 'code': '+370'},
    {'country': 'Luxembourg', 'code': '+352'},
    {'country': 'Madagascar', 'code': '+261'},
    {'country': 'Malawi', 'code': '+265'},
    {'country': 'Malaysia', 'code': '+60'},
    {'country': 'Maldives', 'code': '+960'},
    {'country': 'Mali', 'code': '+223'},
    {'country': 'Malta', 'code': '+356'},
    {'country': 'Marshall Islands', 'code': '+692'},
    {'country': 'Mauritania', 'code': '+222'},
    {'country': 'Mauritius', 'code': '+230'},
    {'country': 'Mexico', 'code': '+52'},
    {'country': 'Micronesia', 'code': '+691'},
    {'country': 'Moldova', 'code': '+373'},
    {'country': 'Monaco', 'code': '+377'},
    {'country': 'Mongolia', 'code': '+976'},
    {'country': 'Montenegro', 'code': '+382'},
    {'country': 'Morocco', 'code': '+212'},
    {'country': 'Mozambique', 'code': '+258'},
    {'country': 'Myanmar (Burma)', 'code': '+95'},
    {'country': 'Namibia', 'code': '+264'},
    {'country': 'Nauru', 'code': '+674'},
    {'country': 'Nepal', 'code': '+977'},
    {'country': 'Netherlands', 'code': '+31'},
    {'country': 'New Zealand', 'code': '+64'},
    {'country': 'Nicaragua', 'code': '+505'},
    {'country': 'Niger', 'code': '+227'},
    {'country': 'Nigeria', 'code': '+234'},
    {'country': 'North Macedonia', 'code': '+389'},
    {'country': 'Norway', 'code': '+47'},
    {'country': 'Oman', 'code': '+968'},
    {'country': 'Pakistan', 'code': '+92'},
    {'country': 'Palau', 'code': '+680'},
    {'country': 'Panama', 'code': '+507'},
    {'country': 'Papua New Guinea', 'code': '+675'},
    {'country': 'Paraguay', 'code': '+595'},
    {'country': 'Peru', 'code': '+51'},
    {'country': 'Philippines', 'code': '+63'},
    {'country': 'Poland', 'code': '+48'},
    {'country': 'Portugal', 'code': '+351'},
    {'country': 'Qatar', 'code': '+974'},
    {'country': 'Romania', 'code': '+40'},
    {'country': 'Russia', 'code': '+7'},
    {'country': 'Rwanda', 'code': '+250'},
    {'country': 'Saint Kitts and Nevis', 'code': '+1-869'},
    {'country': 'Saint Lucia', 'code': '+1-758'},
    {'country': 'Saint Vincent and the Grenadines', 'code': '+1-784'},
    {'country': 'Samoa', 'code': '+685'},
    {'country': 'San Marino', 'code': '+378'},
    {'country': 'Sao Tome and Principe', 'code': '+239'},
    {'country': 'Saudi Arabia', 'code': '+966'},
    {'country': 'Senegal', 'code': '+221'},
    {'country': 'Serbia', 'code': '+381'},
    {'country': 'Seychelles', 'code': '+248'},
    {'country': 'Sierra Leone', 'code': '+232'},
    {'country': 'Singapore', 'code': '+65'},
    {'country': 'Slovakia', 'code': '+421'},
    {'country': 'Slovenia', 'code': '+386'},
    {'country': 'Solomon Islands', 'code': '+677'},
    {'country': 'Somalia', 'code': '+252'},
    {'country': 'South Africa', 'code': '+27'},
    {'country': 'South Sudan', 'code': '+211'},
    {'country': 'Spain', 'code': '+34'},
    {'country': 'Sri Lanka', 'code': '+94'},
    {'country': 'Sudan', 'code': '+249'},
    {'country': 'Suriname', 'code': '+597'},
    {'country': 'Sweden', 'code': '+46'},
    {'country': 'Switzerland', 'code': '+41'},
    {'country': 'Syria', 'code': '+963'},
    {'country': 'Taiwan', 'code': '+886'},
    {'country': 'Tajikistan', 'code': '+992'},
    {'country': 'Tanzania', 'code': '+255'},
    {'country': 'Thailand', 'code': '+66'},
    {'country': 'Togo', 'code': '+228'},
    {'country': 'Tonga', 'code': '+676'},
    {'country': 'Trinidad and Tobago', 'code': '+1-868'},
    {'country': 'Tunisia', 'code': '+216'},
    {'country': 'Turkey', 'code': '+90'},
    {'country': 'Turkmenistan', 'code': '+993'},
    {'country': 'Tuvalu', 'code': '+688'},
    {'country': 'Uganda', 'code': '+256'},
    {'country': 'Ukraine', 'code': '+380'},
    {'country': 'United Arab Emirates', 'code': '+971'},
    {'country': 'United Kingdom', 'code': '+44'},
    {'country': 'United States', 'code': '+1'},
    {'country': 'Uruguay', 'code': '+598'},
    {'country': 'Uzbekistan', 'code': '+998'},
    {'country': 'Vanuatu', 'code': '+678'},
    {'country': 'Vatican City', 'code': '+379'},
    {'country': 'Venezuela', 'code': '+58'},
    {'country': 'Vietnam', 'code': '+84'},
    {'country': 'Yemen', 'code': '+967'},
    {'country': 'Zambia', 'code': '+260'},
    {'country': 'Zimbabwe', 'code': '+263'},
  ];

  final UserController _userController = Setting.User_controller;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController quartierController = TextEditingController();
  final TextEditingController communeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedCountryCode;
  String? selectedCountryName;
  String? selectedGender;
  final _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    // Validation des champs
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer votre nom')),
      );
      return;
    }

    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez entrer votre numéro de téléphone')),
      );
      return;
    }

    if (emailController.text.isNotEmpty &&
        !emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un email valide')),
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un mot de passe')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Le mot de passe doit contenir au moins 6 caractères')),
      );
      return;
    }

    if (dateOfBirthController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez entrer votre date de naissance')),
      );
      return;
    }

    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner votre genre')),
      );
      return;
    }

    // Si toutes les validations sont passées, créer l'utilisateur
    final user = UserModel(
      name: nameController.text,
      phonenumber: "${selectedCountryCode}" + phoneController.text,
      email: emailController.text,
      dateOfBirth: dateOfBirthController.text,
      gender: selectedGender ?? '',
      commune: communeController.text,
      number: numberController.text,
      avenue: avenueController.text,
      quartier: quartierController.text,
      password: passwordController.text,
    );

    final success = await _userController.registerUser(user);

    if (success) {
      print("Added user");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextPage(
            name: nameController.text,
            phone: phoneController.text,
            email: emailController.text,
            dateOfBirth: dateOfBirthController.text,
            gender: selectedGender ?? '',
            country: selectedCountryCode ?? '',
            number: numberController.text,
            avenue: avenueController.text,
            quartier: quartierController.text,
            commune: communeController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Ce numéro de téléphone est déjà utilisé')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildStepper(),

              _buildTitleSection(),
              const SizedBox(height: 10),
              _buildDescriptionSection(),
              const SizedBox(height: 10),
              _buildRequiredFieldNote(),

              const SizedBox(
                height: 20,
              ),

              const Row(
                children: [
                  Text(
                    'Nom complet',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Numéro de téléphone',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration:
                            const InputDecoration(hintText: 'ex : 081...'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),

              const Row(
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: dateOfBirthController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateOfBirthController.text = formattedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select your date of birth',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Text(
                    'Votre Genre',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['Homme', 'Femme'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Genre',
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner votre genre';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Color.fromARGB(255, 64, 123, 255),
                  ),
                  Text(
                    'Informations Addtionnelles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Veuillez inserez les informations en rapport avec votre adresse.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Row(
                children: [
                  Text(
                    'Numéro',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Row(
                children: [
                  Text(
                    'Avenue',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: avenueController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Row(
                children: [
                  Text(
                    'Quartier',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: quartierController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Row(
                children: [
                  Text(
                    'Commune',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: communeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text(
                    'Mot de passe',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Confirmer Mot de passe',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextc
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibilityc,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(
                          255, 64, 123, 255), // Couleur personnalisée
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Suivant'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDescriptionSection() {
  return Text(
    'Veuillez inserez vos informations personnelles.',
    style: TextStyle(
      fontSize: 14,
      color: Colors.grey[600],
    ),
  );
}

Widget _buildRequiredFieldNote() {
  return const Text(
    '*Champs Obligatoires',
    style: TextStyle(
      fontSize: 14,
      color: Colors.red,
    ),
  );
}

Widget _buildTitleSection() {
  return const Row(
    children: [
      Icon(
        Icons.chevron_right_outlined,
        color: Color.fromARGB(255, 64, 123, 255),
      ),
      Text(
        'Informations Personnelles',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget _buildLineConnector() {
  return const Expanded(
    child: Divider(
      color: Colors.grey,
      thickness: 1,
    ),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Row(
      children: [
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 64, 123, 255),
          child: Icon(Icons.app_registration_outlined, color: Colors.white),
        ),
        SizedBox(width: 10),
        Text('Inscription'),
        Spacer(),
        Icon(Icons.more_vert),
      ],
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    centerTitle: true,
  );
}
