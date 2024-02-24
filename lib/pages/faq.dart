import 'package:flutter/material.dart';

class FirstAidPage extends StatefulWidget {
  const FirstAidPage({super.key});
  @override
  State<FirstAidPage> createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  Map<String, List<String>> firstAidSteps = {
    'Cuts and Scrapkjhes': [
      'Clean the wound with soap and water.',
      'Apply an antibiotic ointment.',
      'Cover the wound with a sterile bandage.',
      'Seek medical attention if the wound is deep or bleeding heavily.',
    ],
    'Burns': [
      'Cool the burn under cool (not cold) running water for at least 10 minutes.',
      'Cover the burn with a sterile gauze bandage.',
      'Do not apply butter or ointments to the burn.',
      'Seek medical attention if the burn is severe or covers a large area.',
    ],
    'Sprains and Strains': [
      'Rest the injured area.',
      'Apply ice to reduce swelling.',
      'Compress the area with a bandage.',
      'Elevate the injured limb.',
      'Seek medical attention if the pain is severe or if you suspect a fracture.',
    ],
    'Fractures': [
      'Immobilize the injured limb using a splint or sling to prevent further movement and minimize pain.',
      'Apply ice packs wrapped in cloth to the injured area to help reduce swelling and pain. Avoid applying ice directly to the skin, as it can cause frostbite.',
      'Seek medical attention promptly to assess the extent of the injury and determine appropriate treatment.',
    ],
    'Seizures': [
      'Keep the person safe from injury by moving nearby objects away and creating a cushioned space around them to prevent head or limb injuries.',
      'Do not restrain the person during a seizure, but gently guide them away from dangerous objects or positions if necessary.',
      'After the seizure ends, help the person into a safe position, such as lying on their side, to maintain an open airway and prevent choking. Stay with them and provide reassurance until they fully recover.',
    ],
    'Allergic Reactions (Anaphylaxis)': [
      'Administer epinephrine promptly if the person has an auto-injector (such as an EpiPen) and is experiencing severe allergic symptoms, such as difficulty breathing, swelling of the face or throat, or a rapid heartbeat.',
      'Call emergency services immediately to seek further medical assistance.',
      'Monitor the person\'s breathing and vital signs while waiting for help to arrive, and be prepared to administer additional doses of epinephrine if necessary.',
    ],
    'Insect Bites': [
      'Remove the stinger (if applicable) by scraping it off horizontally with a credit card or your fingernail.',
      'Wash the area with soap and water.',
      'Apply a cold compress to reduce swelling.',
      'Take an antihistamine to alleviate itching and swelling.',
      'Seek medical attention if there is severe swelling, difficulty breathing, or other signs of allergic reaction.',
    ],
    'Snake Bites': [
      'Keep the person calm and still.',
      'Keep the bitten area at or slightly below heart level.',
      'Cover the bite with a clean, dry dressing.',
      'Seek immediate medical attention.',
      'Do not apply a tourniquet or ice pack, and do not attempt to suck out venom.',
    ],
    'Unconsciousness': [
      'Check responsiveness by gently tapping the person and speaking loudly.',
      'If unresponsive, call emergency services immediately.',
      'Check for breathing and perform CPR if necessary.',
      'Place the person in the recovery position (on their side) if breathing but unconscious.',
      'Continue monitoring the person until help arrives.',
    ],
    'Cardiopulmonary Resuscitation (CPR)': [
      'Check for responsiveness by tapping the person and shouting loudly.',
      'If unresponsive, call emergency services and begin CPR immediately.',
      'Perform chest compressions at a rate of 100-120 compressions per minute.',
      'After 30 compressions, give two rescue breaths.',
      'Continue cycles of 30 compressions and 2 breaths until help arrives or the person starts breathing.',
    ],
    'Choking': [
      'Encourage the person to cough to try to dislodge the object.',
      'If the person is unable to cough, perform abdominal thrusts (Heimlich maneuver).',
      'Stand behind the person, wrap your arms around their waist, and make a fist with one hand.',
      'Place the thumb side of your fist just above the person\'s navel and below the ribcage.',
      'Grasp your fist with your other hand and quickly thrust inward and upward.',
      'Continue abdominal thrusts until the object is dislodged or until help arrives.',
    ],
  };
  String? expandedCard;

  void _handleCardTap(String title) {
    setState(() {
      expandedCard = expandedCard == title ? null : title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Aid',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: firstAidSteps.keys.map((title) {
            return GestureDetector(
              onTap: () => _handleCardTap(title),
              child: Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ExpansionPanelList(
                  expansionCallback: (index, isExpanded) {
                    _handleCardTap(
                        title); // Ensure tapping the card toggles its state
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      body: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: firstAidSteps[title]!
                              .map((step) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(step),
                                  ))
                              .toList(),
                        ),
                      ),
                      isExpanded: expandedCard == title,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
