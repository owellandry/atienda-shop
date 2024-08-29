import commentsData from '@/data/commentsData.json';
import '@/styles/commentsSection.css';
import { Avatar, Card } from "@nextui-org/react";

export default function CommentsSection() {
  return (
    <div className="padding relative overflow-hidden w-full max-w-5x3 pd-10 mx-auto">
      <div className="flex items-center gap-4 animate-marquee-left-infinite">
        {commentsData.slice(0, 3).map((comment, index) => (
          <Card key={index} className="comment-card flex items-start gap-4 border rounded-md p-4">
            <Avatar className="comment-avatar w-10 h-10 border">
              <img src={comment.avatar} alt={comment.username} />
            </Avatar>
            <div className="grid gap-1">
              <div className="font-medium">{comment.username}</div>
              <p className="text-muted-foreground text-sm">
                {comment.message}
              </p>
            </div>
          </Card>
        ))}
      </div>
      <div className="flex items-center gap-4 animate-marquee-right-infinite mt-4">
        {commentsData.slice(3).map((comment, index) => (
          <Card key={index} className="comment-card flex items-start gap-4 border rounded-md p-4">
            <Avatar className="comment-avatar w-20 h-10 border">
              <img src={comment.avatar} alt={comment.username} />
            </Avatar>
            <div className="grid gap-1">
              <div className="font-medium">{comment.username}</div>
              <p className="text-muted-foreground text-sm">
                {comment.message}
              </p>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
