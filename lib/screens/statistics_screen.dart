import 'package:flutter/material.dart';
import '../models/game.dart';

class StatisticsScreen extends StatelessWidget {
  final Game game;

  const StatisticsScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text("Player Statistics"),
                elevation: 0,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ListView.separated(
          itemCount: game.players.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final player = game.players[index];
            final stats = _computeStats(player);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerStatDetailScreen(
                      playerName: player,
                      game: game,
                      stats: stats,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        player[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Won ${stats.roundsWon} of ${stats.totalRounds} rounds",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      stats.netAmount >= 0
                          ? "+${stats.netAmount}"
                          : "${stats.netAmount}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: stats.netAmount >= 0
                            ? Colors.green.shade600
                            : Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PlayerStats _computeStats(String player) {
    int roundsWon = 0;
    int totalRounds = game.rounds?.length ?? 0;
    int totalEarned = 0;
    int totalLost = 0;
    Map<int, int> denominationCount = {};

    for (var round in game.rounds ?? <Round>[]) {
      bool wonThisRound = false;
      int winnerGets = 0;
      int playerPay = 0;

      for (var entry in round.entries) {
        if (entry.toPay != -1) {
          winnerGets += entry.toPay;
        }
        if (entry.player == player) {
          if (entry.toPay == -1) {
            wonThisRound = true;
          } else {
            playerPay = entry.toPay;
            denominationCount[entry.toPay] =
                (denominationCount[entry.toPay] ?? 0) + 1;
          }
        }
      }

      if (wonThisRound) {
        roundsWon++;
        totalEarned += winnerGets;
      } else {
        totalLost += playerPay;
      }
    }

    return PlayerStats(
      roundsWon: roundsWon,
      totalRounds: totalRounds,
      totalEarned: totalEarned,
      totalLost: totalLost,
      netAmount: totalEarned - totalLost,
      denominationCount: denominationCount,
    );
  }
}

class PlayerStats {
  final int roundsWon;
  final int totalRounds;
  final int totalEarned;
  final int totalLost;
  final int netAmount;
  final Map<int, int> denominationCount;

  PlayerStats({
    required this.roundsWon,
    required this.totalRounds,
    required this.totalEarned,
    required this.totalLost,
    required this.netAmount,
    required this.denominationCount,
  });
}

class PlayerStatDetailScreen extends StatelessWidget {
  final String playerName;
  final Game game;
  final PlayerStats stats;

  const PlayerStatDetailScreen({
    super.key,
    required this.playerName,
    required this.game,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    double winRate = stats.totalRounds > 0
        ? (stats.roundsWon / stats.totalRounds * 100)
        : 0;

    // Sort denominations by amount
    var sortedDenominations = stats.denominationCount.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.redAccent,
                title: Text(playerName),
                elevation: 0,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Net amount card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: stats.netAmount >= 0
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: stats.netAmount >= 0
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Net Amount",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    stats.netAmount >= 0
                        ? "+${stats.netAmount}"
                        : "${stats.netAmount}",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: stats.netAmount >= 0
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Win/Loss stats row
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Rounds Won",
                    "${stats.roundsWon}",
                    Icons.emoji_events,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    "Rounds Lost",
                    "${stats.totalRounds - stats.roundsWon}",
                    Icons.trending_down,
                    Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Win rate and total rounds
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Win Rate",
                    "${winRate.toStringAsFixed(1)}%",
                    Icons.percent,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    "Total Rounds",
                    "${stats.totalRounds}",
                    Icons.replay,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Earned and Lost
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Total Earned",
                    "+${stats.totalEarned}",
                    Icons.arrow_downward,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    "Total Paid",
                    "-${stats.totalLost}",
                    Icons.arrow_upward,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Denomination breakdown
            if (sortedDenominations.isNotEmpty) ...[
              const Text(
                "Payment Breakdown",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              ...sortedDenominations.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          size: 18.0,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "${entry.key}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${entry.value} time${entry.value == 1 ? '' : 's'}",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "= ${entry.key * entry.value}",
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
