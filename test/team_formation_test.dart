// import 'package:flutter_test/flutter_test.dart';
// import 'package:footsapp/ui/games/add_players/team_formation/team_formation_helper.dart';
// import 'package:footsapp/ui/games/add_players/team_formation/team_player.dart';

// void main() {
//   test("Goal Keeper formation", () {
//     var players = [
//       for (var i = 0; i < 11; ++i)
//         TeamPlayer(
//           color: i,
//           name: "H Player $i",
//           type: TeamType.Home,
//           id: i,
//           position: i,
//         )
//     ];

//     Map goalKeeper = TeamFormationHelper.formGoalKeeper(players);
//     expect(1, goalKeeper.length);
//     expect(0, goalKeeper[0].position);
//   });

//   group("Defenders Test", () {
//     test("Defenders Formation for 11 v 11", () {
//       var players = [
//         for (var i = 0; i < 11; ++i)
//           TeamPlayer(
//             color: i,
//             name: "H Player $i",
//             type: TeamType.Home,
//             id: i,
//             position: i,
//           )
//       ];

//       Map defendersMap = TeamFormationHelper.formDefenders(players);
//       expect(defendersMap.length, 4);

//       defendersMap.forEach((k, v) => expect(v, isA<TeamPlayer>()));
//     });

//     test("Defenders Formation for (5 v 5) or (7 v 7)", () {
//       var players = [
//         for (var i = 0; i < 11; ++i)
//           if (i % 2 == 0)
//             TeamPlayer(
//               color: i,
//               name: "H Player $i",
//               type: TeamType.Home,
//               id: i,
//               position: i,
//             )
//       ];

//       Map defendersMap = TeamFormationHelper.formDefenders(players);
//       expect(defendersMap.length, 4);
//     });
//   });

//   group("Midfielders Test", () {
//     test("Midfielders formation for 11 v 11", () {
//       var players = [
//         for (var i = 0; i < 11; ++i)
//           TeamPlayer(
//             color: i,
//             name: "H Player $i",
//             type: TeamType.Home,
//             id: i,
//             position: i,
//           )
//       ];

//       Map midfieldersMap = TeamFormationHelper.formMidfielders(players);
//       expect(midfieldersMap.length, 2);

//       midfieldersMap.forEach((k, v) => expect(v, isA<TeamPlayer>()));
//     });

//     test("Midfielders for 5v5 or 7v7", () {
//       var players = [
//         for (var i = 0; i < 11; ++i)
//           if (i % 2 == 0)
//             TeamPlayer(
//               color: i,
//               name: "H Player $i",
//               type: TeamType.Home,
//               id: i,
//               position: i,
//             )
//       ];
//       Map midfieldersMap = TeamFormationHelper.formMidfielders(players);
//       expect(midfieldersMap.length, 2);
//     });
//   });
// }
