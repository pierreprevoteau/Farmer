FROM rails:4.2.5

CMD ["rake", "resque:scheduler"]
