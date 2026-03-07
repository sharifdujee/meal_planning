

class UserProfile {
  final String name;
  final String subscriptionType;
  final bool isSubscriptionActive;
  final String? avatarUrl;

  const UserProfile({
    required this.name,
    required this.subscriptionType,
    required this.isSubscriptionActive,
    this.avatarUrl,
  });

  UserProfile copyWith({
    String? name,
    String? subscriptionType,
    bool? isSubscriptionActive,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      isSubscriptionActive: isSubscriptionActive ?? this.isSubscriptionActive,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}