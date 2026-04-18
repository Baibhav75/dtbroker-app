import 'package:flutter/material.dart';

class InboxScreenContent extends StatefulWidget {
  const InboxScreenContent({super.key});

  @override
  State<InboxScreenContent> createState() => _InboxScreenContentState();
}

class _InboxScreenContentState extends State<InboxScreenContent> {
  final List<Message> _messages = [
    Message(
      id: '1',
      senderName: 'John Smith',
      senderImage: 'assets/images/homeimg.png',
      lastMessage: 'Hi, I\'m interested in The Rao\'s villa...',
      timestamp: '2 hours ago',
      isRead: false,
    ),
    Message(
      id: '2',
      senderName: 'Sarah Johnson',
      senderImage: 'assets/images/homeimg.png',
      lastMessage: 'Can we schedule a viewing?',
      timestamp: '5 hours ago',
      isRead: false,
    ),
    Message(
      id: '3',
      senderName: 'Mike Wilson',
      senderImage: 'assets/images/homeimg.png',
      lastMessage: 'Thank you for the information!',
      timestamp: '1 day ago',
      isRead: true,
    ),
    Message(
      id: '4',
      senderName: 'Emma Davis',
      senderImage: 'assets/images/homeimg.png',
      lastMessage: 'Is the property still available?',
      timestamp: '2 days ago',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _messages.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageItem(message);
              },
            );
  }

  Widget _buildMessageItem(Message message) {
    return InkWell(
      onTap: () {
        // Navigate to chat detail
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isRead ? Colors.white : const Color(0xFFE8F5E9).withOpacity(0.3),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(message.senderImage),
                  onBackgroundImageError: (_, __) {},
                  child: message.senderImage.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
                if (!message.isRead)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.senderName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              message.isRead ? FontWeight.normal : FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        message.timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight:
                          message.isRead ? FontWeight.normal : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final String timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.timestamp,
    required this.isRead,
  });
} //